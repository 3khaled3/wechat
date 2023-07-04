// ignore_for_file: library_private_types_in_public_api
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/views/test.dart';
import '../cubits/stores_cubit/stores_cubit.dart';
import '../modelview/showImage.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: BlocProvider.of<StoresCubit>(context).uploadImageFromGallery(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          Navigator.pop(context);
          return Text('Error: ${snapshot.error}');
        }else
         if (snapshot.data==null) {
         
        
          return const nulll();
        } else {
          return showImage(selectedImage: snapshot.data, context: context);
        }
      },
    );
  }
}
