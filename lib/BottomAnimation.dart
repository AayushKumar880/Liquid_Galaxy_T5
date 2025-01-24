import 'package:flutter/material.dart';

class BottomAnimation extends StatefulWidget {
  const BottomAnimation({
    super.key,
    this.width = 300.0,
    this.height = 16.0,
    this.shadowColor1 = Colors.blue,
    this.shadowColor2 = Colors.green,
    this.gradientColors = const [
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.green,
    ],
    this.animationDuration = const Duration(seconds: 2),
    required this.controller,
  });

  final double width;
  final double height;
  final Color shadowColor1;
  final Color shadowColor2;
  final List<Color> gradientColors;
  final Duration animationDuration;
  final AnimationController controller;

  @override
  State<BottomAnimation> createState() => _BottomAnimationState();
}

class _BottomAnimationState extends State<BottomAnimation>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  late Animation<Alignment> _leftAlignAnim;
  late Animation<Alignment> _rightAlignAnim;

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: widget.animationDuration,
    // );

    _leftAlignAnim = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.centerLeft, end: Alignment.centerRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.centerLeft),
        weight: 1,
      ),
    ]).animate(widget.controller);

    _rightAlignAnim = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.centerLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.centerLeft, end: Alignment.centerRight),
        weight: 1,
      ),
    ]).animate(widget.controller);

    widget.controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (context, _) {
              return Center(
                child: Stack(
                  children: [
                    _buildShadowContainer(
                      alignment: _leftAlignAnim.value,
                      shadowColor: widget.shadowColor1,
                    ),
                    _buildShadowContainer(
                      alignment: _rightAlignAnim.value,
                      shadowColor: widget.shadowColor2,
                    ),
                    Center(
                      child: Container(
                        width: widget.width,
                        height: 6.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          gradient: LinearGradient(
                            colors: widget.gradientColors,
                            begin: _leftAlignAnim.value,
                            end: _rightAlignAnim.value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShadowContainer({
    required Alignment alignment,
    required Color shadowColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Align(
        alignment: alignment,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.3),
                offset: Offset.zero,
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
