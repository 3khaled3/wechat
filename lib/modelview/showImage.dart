

// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../cubits/stores_cubit/stores_cubit.dart';

showImage({context, selectedImage}) {
  bool loading = false;
  return BlocBuilder<StoresCubit, StoresState>(builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (selectedImage != null)
            Center(
              child: Image.file(
                selectedImage,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () async {
                  if (selectedImage != null) {
                    loading = true;
                    await BlocProvider.of<StoresCubit>(context)
                        .uploadStores(selectedImage);
                    loading = false;
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: loading
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 35,
                      ))
                    : const Icon(Icons.check),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  });
}
