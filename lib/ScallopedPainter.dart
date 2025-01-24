import 'dart:math';

import 'package:flutter/cupertino.dart';

class ScallopedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final path = Path();
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    const scallopCount = 16; // Total number of curves (inward + outward)

    for (int i = 0; i < scallopCount; i++) {
      final angle = (i * (2 * pi / scallopCount));
      final nextAngle = ((i + 1) * (2 * pi / scallopCount));

      // Start point for the current segment
      final startX = center.dx + radius * cos(angle);
      final startY = center.dy + radius * sin(angle);

      // End point for the current segment
      final endX = center.dx + radius * cos(nextAngle);
      final endY = center.dy + radius * sin(nextAngle);

      // Controlling point for the curve (inward and/or outward)
      final controlRadius = (i % 2 == 0) ? radius * 1.1 : radius * 0.9;
      final controlX =
          center.dx + controlRadius * cos(angle + (nextAngle - angle) / 2);
      final controlY =
          center.dy + controlRadius * sin(angle + (nextAngle - angle) / 2);

      if (i == 0) {
        path.moveTo(startX, startY);
      }

      // Drawing a quadratic bezier curve for each segment
      path.quadraticBezierTo(controlX, controlY, endX, endY);
    }

    path.close(); // Close the path to form the shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
