// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class nulll extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const nulll({Key? key});

  @override
  State<nulll> createState() => _nulllState();
}

class _nulllState extends State<nulll> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
