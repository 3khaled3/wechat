import 'package:flutter/material.dart';

// ignore: camel_case_types
class CallCard extends StatelessWidget {
  const CallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xff161c16),
          ),
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 40)),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/test.jpg"),
                    radius: 35,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "khaled Tarek",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        "09:11",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     Icon(Icons.call,size: 24,color: Colors.red,)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
