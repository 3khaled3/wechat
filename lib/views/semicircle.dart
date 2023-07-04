import 'package:flutter/material.dart';

class SemicirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..arcTo(
        Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: size.width / 2),
        5.7,
        -2, // Change this value to adjust the angle of the semicircle
        true,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SemicirclePainter oldDelegate) => false;
}

class SemicircleWidget extends StatelessWidget {
  const SemicircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SemicirclePainter(),
      child: const SizedBox(
        width: 40,
        height: 40,
      ),
    );
  }
}

