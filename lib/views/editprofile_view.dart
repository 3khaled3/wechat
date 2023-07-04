// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_cubit.dart';

import '../modelview/customTextFaild.dart';
import '../modelview/buildProfileImage.dart';
import '../modelview/snakebar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String? newusername;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Scaffold(
          body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF183E36), Colors.black, Color(0xFF183E36)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(80),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildAccountTitle(),
                  const SizedBox(height: 20),
                  buildProfileImage(),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: "Name",
                    initialValue: FirebaseAuth.instance.currentUser!
                        .displayName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter new username';
                      } else {
                        
                          newusername = value;
                        
                        return null;
                      }                   
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }

  Widget _buildAccountTitle() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return TextButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await BlocProvider.of<AuthCubit>(context)
              .updateDisplayName(newusername!);
          final state = BlocProvider.of<AuthCubit>(context).state;
          if (state is success) {
            showSnackbarMessage(
              context,
              "Username has been updated",
              Colors.green,
            );
          } else if (state is error) {
            final errorMessage = (state).errorMessage;
            showSnackbarMessage(context, errorMessage, Colors.red);
          }
        }
      },
      child: const Text(
        "SAVE",
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
