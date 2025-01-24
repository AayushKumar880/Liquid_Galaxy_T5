import 'dart:math';

import 'package:flutter/cupertino.dart';

class GradientShapePainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final CustomPainter shapePainter;

  GradientShapePainter({
    required this.color1,
    required this.color2,
    required this.shapePainter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = SweepGradient(
      colors: [
        color1,
        color2,
        color1,
      ],
      stops: [0.0, 0.5, 1.0],
      startAngle: 0,
      endAngle: 2 * pi,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.saveLayer(rect, Paint());
    shapePainter.paint(canvas, size);
    canvas.drawPath(
      Path()..addRect(rect),
      paint..blendMode = BlendMode.srcIn,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CreateCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
