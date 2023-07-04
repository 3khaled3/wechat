// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()); 

  
Future<Map<String, dynamic>?> getUserProfile(String userId) async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}


}
