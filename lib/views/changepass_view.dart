// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../modelview/logintextfaild.dart';
import '../modelview/snakebar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? currentPss;
  String? newPss;
  String? confirmPss;
  var box = Hive.box('myBox');
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildAccountTitle(),
                    SizedBox(height: MediaQuery.sizeOf(context).height * .2),
                    const SizedBox(height: 20),
                    TextFaildLogin(
                      hintText: "Current password",
                      obscureText: true,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter current password';
                        } else if (box.get('password') != value) {
                          return 'The password you entered is incorrect';
                        } else {
                          currentPss = value;

                          return null;
                        }
                        // Add more custom validation logic here if needed
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFaildLogin(
                      obscureText: true,
                      hintText: "New password",
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter new password';
                        } else {
                          newPss = value;

                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFaildLogin(
                      hintText: "Confirm new password",
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter new password again';
                        } else if (newPss != value) {
                          return 'Password does not match';
                        } else {
                          confirmPss = value;

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
        ),
      ),
    );
  }

  Widget _buildAccountTitle() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Change password",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  _buildSaveButton() {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return TextButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await BlocProvider.of<AuthCubit>(context)
                .updataPassword(confirmPss!);
            final state = BlocProvider.of<AuthCubit>(context).state;
            if (state is success) {
              showSnackbarMessage(
                context,
                "password has been updated",
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
    });
  }
}
