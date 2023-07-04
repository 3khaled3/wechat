import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/cubits/chat_cubit/chat_cubit.dart';
import 'package:intl/intl.dart';


import '../views/chat_view.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return FutureBuilder<Map<String, dynamic>?>(
          future: BlocProvider.of<ChatCubit>(context).getUserProfile(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {}

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            Map<String, dynamic>? userProfile = snapshot.data;

            if (userProfile != null &&
                userProfile['email'] !=
                    FirebaseAuth.instance.currentUser!.email) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          resever: userProfile['email'],
                          imageurl: userProfile['photoURL'],
                          displayname: userProfile['displayName']),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff161c16),
                  ),
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: userProfile['photoURL'] == null
                                ? const AssetImage("assets/new.png")
                                : NetworkImage(userProfile['photoURL'])
                                    as ImageProvider<Object>,
                            radius: 35,
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  userProfile['displayName'] ?? "nnn",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                const SizedBox(height: 15,),
                                 Text(
                                  "last seen : ${ DateFormat('MMM d, h:mm a').format((userProfile['lastseen'] as Timestamp).toDate()) }",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                         
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: 0,
              );
            }
          },
        );
      },
    );
  }
}
