// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class appinfo extends StatelessWidget {
  const appinfo({super.key});
  final String info =
      "https://firebasestorage.googleapis.com/v0/b/wechat-d43c1.appspot.com/o/info.jpg?alt=media&token=47a94fb9-f2cf-4dd3-8f5e-debeb4ec6cec";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: BuildBackground(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            BuildImageSection(),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "khaled tarek",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: "Pacifico",
              ),
            ),
            const Text(
              "FLUTTER DEVELOPER",
              style: TextStyle(
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: 16,
              ),
            ),
            const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 105, 105, 105),
                endIndent: 30,
                indent: 30),
            BuildViewData("01273793869", Icons.phone),
            BuildViewData("dev.khaledtarek@gmail.com", Icons.email),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    ));
  }

  CircleAvatar BuildImageSection() {
    return CircleAvatar(
      radius: 112,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundImage: NetworkImage(info),
        radius: 110,
      ),
    );
  }

  BoxDecoration BuildBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF183E36), Colors.black, Color(0xFF183E36)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(80),
      ),
    );
  }

  Padding BuildViewData(data, icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 238, 238, 238),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
            Text(
              data,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
