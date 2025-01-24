import 'package:flutter/material.dart';

class QuadrantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);

    path.arcToPoint(
      Offset(size.width, size.height / 2),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );

    path.arcToPoint(
      Offset(size.width / 2, size.height),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );

    path.arcToPoint(
      Offset(0, size.height / 2),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );

    path.arcToPoint(
      Offset(size.width / 2, 0),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
