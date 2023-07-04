// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GroupchatScreen extends StatefulWidget {
  GroupchatScreen({
    super.key,
    required this.displayname,
    required this.imageurl,
  });

  @override
  _GroupchatScreenState createState() => _GroupchatScreenState();

  String displayname;
  String? imageurl;
}

class _GroupchatScreenState extends State<GroupchatScreen>
    with WidgetsBindingObserver {
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('messagesg')
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
        appBar: AppBar(
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
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff183E36), Colors.black, Color(0xff183E36)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(80),
              ),
            ),
            child: SafeArea(
                child: Column(children: [
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _messageStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    var messages = snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        final data = document.data()! as Map<String, dynamic>;

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToBottom();
                        });
                        return data['sender'] !=
                                FirebaseAuth.instance.currentUser!.email
                            ? BubbleSpecialThree(
                                text: data['massege'] ??
                                    "a", // Use the actual message content here
                                color: const Color(0xFFE8E8EE),
                                tail: false,
                                isSender: false,
                              )
                            : BubbleSpecialThree(
                                text: data['massege'] ?? "a",
                                color: const Color(0xFF1B97F3),
                                tail: false,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              );
                      },
                    ).toList();
                    messages = messages.reversed.toList();
                    return SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: messages,
                      ),
                    );
                  },
                ),
              ),
              MessageBar(
                messageBarColor: const Color.fromARGB(82, 19, 24, 19),
                onSend: (value) async {
                  String? sendername =
                      FirebaseAuth.instance.currentUser!.displayName;

                  final collectionRef =
                      FirebaseFirestore.instance.collection('messagesg');
                  if (!(await collectionRef.doc().get()).exists) {
                    await collectionRef
                        .add({
                          'massege': " $sendername: \n $value",
                          "massegeTime": DateTime.now(),
                          'sender': FirebaseAuth.instance.currentUser!.email
                        })
                        .then((value) {})
                        .catchError((error) {});
                  }
                  setState(() {
                    // Update the UI if needed
                  });
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
              )
            ]))));
  }
}
