import 'dart:math';

import 'package:flutter/material.dart';

import 'CustomEclipse.dart';
import 'GradientPainter.dart';
import 'HexagonalPainter.dart';
import 'QuadrantPainter.dart';
import 'ScallopedPainter.dart';

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _shapeAnimation;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _shapeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 2.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 3.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 3.0, end: 4.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _colorAnimation1 = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.blue,
          end: Colors.purple,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.purple,
          end: Colors.blue,
        ),
      ),
    ]).animate(_controller);

    _colorAnimation2 = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.green,
          end: Colors.orange,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.orange,
          end: Colors.green,
        ),
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: _rotationAnimation.value,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_shapeAnimation.value < 1)
                    CustomPaint(
                      size: Size(243, 243),
                      painter: GradientShapePainter(
                        color1: _colorAnimation1.value!,
                        color2: _colorAnimation2.value!,
                        shapePainter: CreateCircle(),
                      ),
                    ),
                  if (_shapeAnimation.value >= 1 && _shapeAnimation.value < 2)
                    CustomPaint(
                      size: Size(243, 243),
                      painter: GradientShapePainter(
                        color1: _colorAnimation1.value!,
                        color2: _colorAnimation2.value!,
                        shapePainter: ScallopedPainter(),
                      ),
                    ),
                  if (_shapeAnimation.value >= 2 && _shapeAnimation.value < 3)
                    CustomPaint(
                      size: Size(200, 300),
                      painter: GradientShapePainter(
                        color1: _colorAnimation1.value!,
                        color2: _colorAnimation2.value!,
                        shapePainter: CustomEclipsePainter(),
                      ),
                    ),
                  if (_shapeAnimation.value >= 3)
                    CustomPaint(
                      size: Size(243, 243),
                      painter: GradientShapePainter(
                        color1: _colorAnimation1.value!,
                        color2: _colorAnimation2.value!,
                        shapePainter: HexagonPainter(),
                      ),
                    ),
                ],
              ),
            ),
            CustomPaint(
              size: Size(100, 100),
              painter: QuadrantPainter(),
            ),
          ],
        );
      },
    );
  }
}
