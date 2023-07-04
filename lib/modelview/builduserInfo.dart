
// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../cubits/auth_cubit/auth_cubit.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return FirebaseAuth.instance.currentUser == null
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.white,
                  size: 70,
                  secondRingColor: Colors.green,
                  thirdRingColor: Colors.purple),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        FirebaseAuth.instance.currentUser!.photoURL == null
                            ? const AssetImage("assets/new.png")
                            : NetworkImage(FirebaseAuth.instance.currentUser!
                                .photoURL!) as ImageProvider<Object>,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(FirebaseAuth.instance.currentUser!.email.toString(),
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 8),
                ],
              ),
            );
    });
  }
}
