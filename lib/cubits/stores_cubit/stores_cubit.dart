// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  StoresCubit() : super(StoresInitial());

  File? _selectedImage;

  Future<File?>? uploadImageFromGallery() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile? pickedImage =
        // ignore: deprecated_member_use
        await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      // emit(success());
      return _selectedImage;
    } else {
      return null;
      // Navigate back if no image selected
    }
  }

  Future<File?>? uploadImageFromCamera() async {
    final pickedImage =

        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      bool? isImageSaved = await GallerySaver.saveImage(pickedImage.path);
      if (isImageSaved == true) {
        _selectedImage = File(pickedImage.path);
        return _selectedImage;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<String?> uploadStores(newPhoto) async {
    emit(waitting());
    try {
      List<String> images = await _getCurrentData();
      if (newPhoto != null) {
        final FirebaseStorage storage = FirebaseStorage.instance;
        String fileName = basename(newPhoto.path);
        Reference reference = storage
            .ref('stores/${FirebaseAuth.instance.currentUser!.uid}/$fileName');
        await reference.putFile(newPhoto);
        String downloadUrl = await reference.getDownloadURL();
        images.add(downloadUrl);
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('stores');

        await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          "displayName": FirebaseAuth.instance.currentUser!.displayName,
          "email": FirebaseAuth.instance.currentUser!.email,
          "profileimage": FirebaseAuth.instance.currentUser!.photoURL,
          "storyURL": images
        });
        emit(success());
        return downloadUrl;
      } else {
        emit(error("errrrrrrror"));
        return null;
      }
    } catch (e) {
      emit(error(e.toString()));
      return null;
    }
  }

  _getCurrentData() async {
    List<String> images = [];
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('stores')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          List<dynamic> storyUrls = data['storyURL'];
          List<String> stories =
              storyUrls.map((url) => url.toString()).toList();
          return stories;
        }
      } else {
        return images;
      }

      // Return an empty list if the document doesn't exist or encounters an error
      return images;
    } catch (e) {
      return images;
    }
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('stores')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        emit(success());
        return snapshot.data() as Map<String, dynamic>;
      } else {
        emit(error('User profile not found'));
        return null;
      }
    } catch (e) {
      emit(error("Error retrieving user profile: $e"));
      return null;
    }
  }
}
