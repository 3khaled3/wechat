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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF183E36), Colors.black, Color(0xFF183E36)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: GradientRotation(80),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 112,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundImage: NetworkImage(info),
                radius: 110,
              ),
            ),
            const SizedBox(height: 16,),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 238, 238, 238),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.phone),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "01273793869",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 238, 238, 238),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.email),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "dev.khaledtarek@gmail.com",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
