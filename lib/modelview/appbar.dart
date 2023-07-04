
  import 'package:flutter/material.dart';

Widget appbar() {
    return Row(
      children: [
        
        const SizedBox(width: 12),
        const Text(
          "wechat",
          style: TextStyle(
                color: Colors.grey,
                fontSize: 22,
                // fontFamily: "Pacifico",
              ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }