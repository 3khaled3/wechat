
// ignore_for_file: file_names, camel_case_types, duplicate_ignore

// ignore: camel_case_types
import 'package:flutter/material.dart';

import '../views/add_view.dart';

class addstory extends StatelessWidget {
  const addstory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 180,
        width: 140,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: const Color.fromARGB(0, 158, 158, 158),
        ),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImageScreen(),
                  ));
            },
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(0, 255, 255, 255))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const Spacer(),
                const Text(
                  "Create",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Text(
                  " Your Story",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
              ],
            )),
      ),
    );
  }
}
