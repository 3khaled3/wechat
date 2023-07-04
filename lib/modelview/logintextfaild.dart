import 'package:flutter/material.dart';

class TextFaildLogin extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const TextFaildLogin({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
    );
  }
}
