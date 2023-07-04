// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/views/test.dart';
import '../cubits/stores_cubit/stores_cubit.dart';
import '../modelview/showImage.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: BlocProvider.of<StoresCubit>(context).uploadImageFromCamera(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          Navigator.pop(context);
          return Text('Error: ${snapshot.error}');
        } else
         if (snapshot.data==null) {
         
        
          return const nulll();
        } {
          return showImage(selectedImage: snapshot.data, context: context);
        }
      },
    );
  }
}
