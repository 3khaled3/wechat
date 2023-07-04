// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wechat/modelview/logintextfaild.dart';
import 'package:wechat/views/forgetpassword_view.dart';
import 'package:wechat/views/register_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../modelview/snakebar.dart';
import 'navegator_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    loginAuto(context);
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
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
              ? buildCircleIndicator()
              : Center(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/logo3.png",
                              width: MediaQuery.sizeOf(context).height * .3),
                          const SizedBox(height: 80),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  buildEmailTextFaild(context),
                                  const SizedBox(height: 16),
                                  buildPassTextFaild(context),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      buildForgetPassButtom(context),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  buildLoginButtom(context),
                                  const SizedBox(height: 40),
                                  buildDontHaveAccount(context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      );
    });
  }

  Center buildCircleIndicator() {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
          color: Colors.white,
          size: 70,
          secondRingColor: Colors.green,
          thirdRingColor: Colors.purple),
    );
  }

  TextFaildLogin buildEmailTextFaild(BuildContext context) {
    return TextFaildLogin(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email ';
        }
        return null;
      },
      hintText: "Email ",
      onChanged: (value) {
        BlocProvider.of<AuthCubit>(context).emailAddress = value;
      },
    );
  }

  TextFaildLogin buildPassTextFaild(BuildContext context) {
    return TextFaildLogin(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Password';
        }
        return null;
      },
      hintText: "Password",
      onChanged: (value) {
        BlocProvider.of<AuthCubit>(context).password = value;
      },
      obscureText: true,
    );
  }

  ElevatedButton buildLoginButtom(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await loginOnpPressed(context);
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      child: const Text('LOGIN'),
    );
  }

  Row buildDontHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: () {
            GoToRegister(context);
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }

  TextButton buildForgetPassButtom(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgetPasswordScreen(),
            ));
        // Forgot Password functionality
      },
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void GoToRegister(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ));
  }

  Future<void> loginOnpPressed(BuildContext context) async {
    await BlocProvider.of<AuthCubit>(context).login();
    final state = BlocProvider.of<AuthCubit>(context).state;
    if (state is success) {
      showSnackbarMessage(
        context,
        "Success",
        Colors.green,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ),
      );
    } else if (state is error) {
      final errorMessage = (state).errorMessage;
      showSnackbarMessage(context, errorMessage, Colors.red);
    }
  }

  void loginAuto(BuildContext context) {
    final box = Hive.box('myBox');
    final storedEmail = box.get('emailAddress');
    final storedPassword = box.get('password');

    if (storedEmail != null && storedPassword != null) {
      BlocProvider.of<AuthCubit>(context).emailAddress = storedEmail;
      BlocProvider.of<AuthCubit>(context).password = storedPassword;
      BlocProvider.of<AuthCubit>(context).login();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ),
        );
      });
    }
  }
}
