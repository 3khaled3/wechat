// ignore_for_file: must_be_immutable, deprecated_member_use, non_constant_identifier_names, library_private_types_in_public_api

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  ChatScreen({
    super.key,
    required this.resever,
    required this.displayname,
    required this.imageurl,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
  String resever;
  String displayname;
  String? imageurl;
}
class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('massegeTime', descending: true)
      .snapshots();
  final ScrollController _scrollController = ScrollController();
  bool _isKeyboardVisible = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeMetrics() {
    final keyboardHeight = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = keyboardHeight > 0;
      if (!_isKeyboardVisible) {
        _scrollToBottom();
      }
    });
  }
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _BuildAppBar(context),
      body: Container(
        decoration: _BuildBackGround(),
        child: SafeArea(
          child: Column(children: [
            const SizedBox(
              height: 8,
            ),
            _BuildAllmassegeSection(),
            _BuildSendMassegeSection()
          ]),
        ),
      ),
    );
  }

  Expanded _BuildAllmassegeSection() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          List<StatelessWidget> messages = _BuildAllMasseges(snapshot);
          messages = messages.reversed.toList();
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: messages,
            ),
          );
        },
      ),
    );
  }

  MessageBar _BuildSendMassegeSection() {
    return MessageBar(
      messageBarColor: const Color.fromARGB(82, 19, 24, 19),
      onSend: (value) async {
        // Add the code to create the collection if it doesn't exist
        await _SendMassegeMethod(value);
      },
      actions: [
        InkWell(
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 24,
          ),
          onTap: () {},
        ),
        const SizedBox(width: 8),
        InkWell(
          child: const Icon(
            Icons.camera_alt,
            color: Colors.green,
            size: 24,
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Future<void> _SendMassegeMethod(String value) async {
    final collectionRef = FirebaseFirestore.instance.collection('messages');
    if (!(await collectionRef.doc().get()).exists) {
      await collectionRef
          .add({
            'massege': value,
            "massegeTime": DateTime.now(),
            'resever': widget.resever,
            'sender': FirebaseAuth.instance.currentUser!.email
          })
          .then((value) {})
          .catchError((error) {});
    }
    setState(() {
      // Update the UI if needed
    });
  }

  List<StatelessWidget> _BuildAllMasseges(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    var messages = snapshot.data!.docs.map(
      (DocumentSnapshot document) {
        final data = document.data()! as Map<String, dynamic>;
        if (data['sender'] == FirebaseAuth.instance.currentUser!.email &&
                data['resever'] == widget.resever ||
            data['resever'] == FirebaseAuth.instance.currentUser!.email &&
                data['sender'] == widget.resever) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
          return data['sender'] != FirebaseAuth.instance.currentUser!.email
              ? _BuildResiveMassegeBuble(data)
              : _BuildSendMassegeBuble(data);
        } else {
          return Container();
        }
      },
    ).toList();
    return messages;
  }

  BubbleSpecialThree _BuildSendMassegeBuble(Map<String, dynamic> data) {
    return BubbleSpecialThree(
      text: data['massege'] ?? "a",
      color: const Color(0xFF1B97F3),
      tail: false,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  BubbleSpecialThree _BuildResiveMassegeBuble(Map<String, dynamic> data) {
    return BubbleSpecialThree(
      text: data['massege'] ?? "a", // Use the actual message content here
      color: const Color(0xFFE8E8EE),
      tail: false,
      isSender: false,
    );
  }

  BoxDecoration _BuildBackGround() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff183E36), Colors.black, Color(0xff183E36)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(80),
      ),
    );
  }

  AppBar _BuildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff161c16),
      leadingWidth: 30,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: widget.imageurl == null
                ? const AssetImage("assets/new.png")
                : NetworkImage(widget.imageurl.toString())
                    as ImageProvider<Object>,
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: const Color.fromARGB(0, 24, 62, 54),
                padding: EdgeInsets.zero,
                elevation: 2.0,
              ),
              child: Container(),
            ),
          ),
          const SizedBox(width: 10),
          Text(widget.displayname),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_left_outlined),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(icon: const Icon(Icons.call), onPressed: () {}),
      ],
    );
  }
}
