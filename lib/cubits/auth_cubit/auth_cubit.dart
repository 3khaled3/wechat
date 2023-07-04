// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({this.emailAddress, this.password}) : super(AuthInitial());
  String? emailAddress = " a", password = " a", userName = " a";
  var box = Hive.box('myBox');
  UserCredential? useraccess;
  
  Future<void> createAccountAndSendEmailVerification() async {
    try {
      if (emailAddress != null && password != null && userName != null) {
        emit(waitting());
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress!,
          password: password!,
        );
        User? user = credential.user;
        await user!.updateDisplayName(userName);
        await user.sendEmailVerification();
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');

        await usersCollection.doc(user.uid).set({
          'uid': user.uid,
          "displayName": userName,
          "email": emailAddress,
          "photoURL": user.photoURL,
          "lastseen": user.metadata.lastSignInTime
        });
        emit(success());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(error("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(error("The account already exists for that email."));
      } else {
        emit(error(e.toString()));
      }
    } catch (e) {
      emit(error(e.toString()));
    }
  }

  login() async {
    try {
      emit(waitting());
      if (emailAddress != null && emailAddress != null) {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress!, password: password!);
        if (credential.user!.emailVerified == true) {
          box.put('emailAddress', emailAddress);
          box.put('password', password);
          useraccess = credential;
          CollectionReference usersCollection =
              FirebaseFirestore.instance.collection('users');
          await usersCollection.doc(credential.user!.uid).set({
            'uid': credential.user!.uid,
            "displayName": credential.user!.displayName,
            "email": emailAddress,
            "photoURL": credential.user!.photoURL,
            "lastseen": credential.user!.metadata.lastSignInTime
          });
          emit(success());
        } else {
          User? user = credential.user;
          await user!.sendEmailVerification();

          emit(error("Check your mail and Verifiy your account."));
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(error("No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(error("Wrong password provided for that user."));
      }
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      emit(waitting());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(success());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(error("No user found for that email."));
      } else {
        emit(error(e.toString()));
      }
    }
  }

  Future<void> updataPassword(String newPassword) async {
    try {
      emit(waitting());
      await useraccess!.user!.updatePassword(newPassword);
      emit(success());
      box.put('password', newPassword);
    } on FirebaseAuthException catch (e) {
      emit(error(e.toString()));
    }
  }

  Future<void> updateDisplayName(String newuserName) async {
    try {
      emit(waitting());
      await FirebaseAuth.instance.currentUser!.updateDisplayName(newuserName);
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      await documentRef.update({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        "displayName": newuserName,
        "email": FirebaseAuth.instance.currentUser!.email,
        "photoURL": FirebaseAuth.instance.currentUser!.photoURL,
        "lastseen": FirebaseAuth.instance.currentUser!.metadata.lastSignInTime
      });

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('stores')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        await FirebaseFirestore.instance
            .collection('stores')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "displayName": FirebaseAuth.instance.currentUser!.displayName,
          "profileimage": FirebaseAuth.instance.currentUser!.photoURL,
        });
      }

      emit(success());
    } on FirebaseAuthException catch (e) {
      emit(error(e.toString()));
    }
  }

  File? _selectedImage;

  _uploadImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      return _selectedImage;
    } else {
      return null;
    }
  }

  Future<String?> updateProfilePhoto() async {
    emit(waitting());
    final FirebaseStorage storage = FirebaseStorage.instance;
    User? user = FirebaseAuth.instance.currentUser;
    try {
      var newPhoto = await _uploadImageFromGallery();
      if (newPhoto != null) {
        if (user!.photoURL != null) {
          await storage.refFromURL(user.photoURL!).delete();
        }

        String fileName = basename(newPhoto.path);
        Reference reference = storage.ref('profile_photos/$fileName');
        await reference.putFile(newPhoto);
        String downloadUrl = await reference.getDownloadURL();
        await user.updatePhotoURL(downloadUrl);
        DocumentReference documentRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        await documentRef.update({
          'uid': user.uid,
          "displayName": user.displayName,
          "email": user.email,
          "photoURL": downloadUrl,
          "lastseen": user.metadata.lastSignInTime
        });

        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('stores')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

        if (snapshot.exists) {
          await FirebaseFirestore.instance
              .collection('stores')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "displayName": FirebaseAuth.instance.currentUser!.displayName,
            "profileimage": FirebaseAuth.instance.currentUser!.photoURL,
          });
        }

        emit(success());
        return downloadUrl;
      } else {
        emit(AuthInitial());
        return null;
      }
    } catch (e) {
      emit(error(e.toString()));
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      emit(waitting());
      await FirebaseAuth.instance.signOut();
      emit(success());
    } catch (e) {
      emit(error(e.toString()));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
