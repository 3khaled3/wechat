// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String? initialValue;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.title,
    this.initialValue,
    this.validator,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: _controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: widget.title,
          border: const OutlineInputBorder(),
        ),
        validator: widget.validator,
      ),
    );
  }
}
