import 'dart:math';

import 'package:flutter/cupertino.dart';

class HexagonPainter extends CustomPainter {
  final double cornerRadius = 20;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    final height = size.height;
    final width = size.width;
    final center = Offset(width / 2, height / 2);
    final radius = width / 2;

    final points = List<Offset>.generate(6, (index) {
      final angle = index * pi / 3 - pi / 6;
      return Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    });

    final firstPoint = points[0];
    path.moveTo(firstPoint.dx, firstPoint.dy);

    for (var i = 0; i < points.length; i++) {
      final current = points[i];
      final next = points[(i + 1) % points.length];

      final controlPoint = next;

      final angle = (i + 1) * pi / 3 - pi / 6;
      final nextAngle = ((i + 2) % 6) * pi / 3 - pi / 6;

      final endPoint = Offset(
          next.dx + cornerRadius * (cos(nextAngle) - cos(angle)),
          next.dy + cornerRadius * (sin(nextAngle) - sin(angle)));

      path.conicTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy, 1.0);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
