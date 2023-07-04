// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wechat/modelview/logintextfaild.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../modelview/snakebar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = " ";
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
                            const SizedBox(height: 40),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: [
                                  TextFaildLogin(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email ';
                                      } else {
                                        email = value;
                                        return null;
                                      }
                                      // Add more custom validation logic here if needed
                                    },
                                    hintText: "Email ",
                                    onChanged: (String? value) {},
                                  ),
                                  const SizedBox(height: 25),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .forgetPassword(email);
                                        final state =
                                            BlocProvider.of<AuthCubit>(context)
                                                .state;


                                        if (state is success) {
                                          showSnackbarMessage(
                                            context,
                                            "Check your mail and resrt password",
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
                                    child: const Text('Send reset link'),
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
