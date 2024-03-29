// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/views/appinfo_view.dart';
import 'package:wechat/views/changepass_view.dart';
import 'package:wechat/views/editprofile_view.dart';
import 'package:wechat/views/login_view.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../modelview/builduserInfo.dart';
import '../modelview/buttomprofil.dart';
import '../modelview/snakebar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: _BuildBackGround(),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const UserInformation(),
            const Divider(),
            _BuildEditProfileButtom(context),
            const Divider(),
            _BuildChangePassButtom(context),
            const Divider(),
            _BuildAppInfoButtom(context),
            const Divider(),
            BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              return _BuildLogOutButtom(context);
            })
          ],
        ),
      )),
    ));
  }

  CustomElevatedButton _BuildLogOutButtom(BuildContext context) {
    return CustomElevatedButton(
              title: 'Logout',
              icon: Icons.logout,
              onPressed: () async {
                await BlocProvider.of<AuthCubit>(context).signOut();
                final state = BlocProvider.of<AuthCubit>(context).state;
                if (state is success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                } else if (state is error) {
                  final errorMessage = (state).errorMessage;
                  showSnackbarMessage(context, errorMessage, Colors.red);
                }
                // Navigate to the change password screen
              },
            );
  }

  CustomElevatedButton _BuildAppInfoButtom(BuildContext context) {
    return CustomElevatedButton(
            title: 'App info',
            icon: Icons.info_outline,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const appinfo();
                },
              ));
            },
          );
  }

  CustomElevatedButton _BuildChangePassButtom(BuildContext context) {
    return CustomElevatedButton(
            title: 'Change Password',
            icon: Icons.lock,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ChangePassword();
                },
              ));
              // Navigate to the change password screen
            },
          );
  }

  CustomElevatedButton _BuildEditProfileButtom(BuildContext context) {
    return CustomElevatedButton(
            title: 'Edit Profile',
            icon: Icons.edit,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const EditProfile();
                },
              ));
            },
          );
  }

  BoxDecoration _BuildBackGround() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF183E36), Colors.black, Color(0xFF183E36)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(80),
      ),
    );
  }
}
