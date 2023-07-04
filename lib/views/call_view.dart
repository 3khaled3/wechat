// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import '../modelview/appbar.dart';
// import '../modelview/buildCallCard.dart';

// class CallView extends StatefulWidget {
//   const CallView({Key? key}) : super(key: key);

//   @override
//   _CallViewState createState() => _CallViewState();
// }

// class _CallViewState extends State<CallView> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xff183E36), Colors.black, Color(0xff183E36)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             transform: GradientRotation(80),
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               appbar(),
//               const SizedBox(height: 10),
//               const Expanded(
//                 child: buildCallCardList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
