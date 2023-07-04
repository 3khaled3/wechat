import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:wechat/views/login_view.dart';
import 'cubits/auth_cubit/auth_cubit.dart';
import 'cubits/chat_cubit/chat_cubit.dart';
import 'cubits/stores_cubit/stores_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  cameras = await availableCameras();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(),
      ),
      BlocProvider(
        create: (context) => ChatCubit(),
      ),
      BlocProvider(
        create: (context) => StoresCubit(),
      ),
    ],
    child: MaterialApp(
      home: LoginScreen(),
      // home: sssssssss(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
