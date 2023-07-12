// ignore_for_file: file_names, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wechat/modelview/snakebar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../cubits/auth_cubit/auth_cubit.dart';



buildProfileImage() {
  return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
    return  state is waitting
              ? Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.white,
                      size: 70,
                      secondRingColor: Colors.green,
                      thirdRingColor: Colors.purple),
                )
              : Container(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      margin: const EdgeInsets.symmetric(vertical: 40),
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            CircleAvatar(
               backgroundImage:
                        FirebaseAuth.instance.currentUser!.photoURL == null
                            ? const AssetImage("assets/new.png")
                            : CachedNetworkImageProvider(FirebaseAuth.instance.currentUser!
                                .photoURL!) as ImageProvider<Object>,
              child: ElevatedButton(
                onPressed: () async {
                
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(0, 24, 62, 54),
                  padding: EdgeInsets.zero,
                  elevation: 2.0,
                ),
                child: Container(),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 40,
                width: 40,
                child: RawMaterialButton(
                  onPressed: () async{  await BlocProvider.of<AuthCubit>(context)
                      .updateProfilePhoto();
                  final state = BlocProvider.of<AuthCubit>(context).state;
                  if (state is success) {
                    showSnackbarMessage(
                      context,
                      "Success",
                      Colors.green,
                    );
                  } else if (state is error) {
                    final errorMessage = (state).errorMessage;
                    showSnackbarMessage(context, errorMessage, Colors.red);
                  }},
                  elevation: 2.0,
                  fillColor: const Color(0xFF183E36),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.camera_alt_sharp,
                    size: 22,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
