// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wechat/modelview/storycard.dart';

import 'buildAddstoryscetion.dart';

Widget buildStorySection() {
  bool currentuseraddstory = false;
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('stores').snapshots(),
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

          if (data['uid'] == FirebaseAuth.instance.currentUser!.uid) {
            currentuseraddstory = true;
            return Container(
                child: const SizedBox(
              width: 0,
              height: 0,
            ));
          }

          return Container(child: StoryCard(uid: data['uid']));
        },
      ).toList();

      messages.insert(0, Container(child: const addstory()));
      if (currentuseraddstory) {
        messages.insert(
            1,
            Container(
                child: StoryCard(uid: FirebaseAuth.instance.currentUser!.uid)));
      }

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: messages,
        ),
      );
    },
  );
}
