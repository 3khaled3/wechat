// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

import 'chatcard.dart';
import 'package:flutter/material.dart';

Widget buildChatCardList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      final messages = snapshot.data!.docs.map(
        (DocumentSnapshot document) {
          final data = document.data()! as Map<String, dynamic>;

          return ChatCard(uid: data['uid']);
        },
      ).toList();

      return SingleChildScrollView(
        child: Column(
          children: messages,
        ),
      );
    },
  );
}
