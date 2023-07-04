import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context, String message,Color? backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(duration:const Duration(seconds: 2) ,backgroundColor: backgroundColor,
      content: Text(message),
    ),
  );
}
