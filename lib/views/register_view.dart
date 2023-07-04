// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wechat/modelview/logintextfaild.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

import '../modelview/snakebar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff183E36), Colors.black, Color(0xff183E36)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(80),
              ),
            ),
            child: state is waitting
                ? Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        color: Colors.white,
                        size: 70,
                        secondRingColor: Colors.green,
                        thirdRingColor: Colors.purple),
                  )
                : Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/logo3.png",width: MediaQuery.sizeOf(context).height*.3),
                            const SizedBox(height: 80),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: [
                                  TextFaildLogin(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your username';
                                      } else {
                                        BlocProvider.of<AuthCubit>(context)
                                            .userName = value;
                                        return null;
                                      }
                                    },
                                    hintText: "Username",
                                    onChanged: (String? value) {},
                                  ),
                                  const SizedBox(height: 16),
                                  TextFaildLogin(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email ';
                                      } else {
                                        BlocProvider.of<AuthCubit>(context)
                                            .emailAddress = value;
                                        return null;
                                      }
                                    },
                                    hintText: "Email ",
                                    onChanged: (String? value) {},
                                  ),
                                  const SizedBox(height: 16),
                                  TextFaildLogin(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      } else {
                                        BlocProvider.of<AuthCubit>(context)
                                            .password = value;
                                        return null;
                                      }
                                    },
                                    hintText: "Password",
                                    onChanged: (String? value) {},
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 25),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .createAccountAndSendEmailVerification();
                                        final state =
                                            BlocProvider.of<AuthCubit>(context)
                                                .state;

                                        if (state is success) {
                                          showSnackbarMessage(
                                            context,
                                            "Check your mail and Verifiy your account",
                                            Colors.green,
                                          );
                                        } else if (state is error) {
                                          final errorMessage =
                                              (state).errorMessage;
                                          showSnackbarMessage(context,
                                              errorMessage, Colors.red);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text('Register'),
                                  ),
                                  const SizedBox(height: 16),
                                
                                  const SizedBox(height: 8),
                                  
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Alreedy have an account !",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Navigation to Sign Up screen
                                        },
                                        child: const Text(
                                          'Sign in',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
