import 'package:flutter/material.dart';

class AnimatedBorderGradient extends StatefulWidget {
  const AnimatedBorderGradient({
    super.key,
    this.radius = 200,
    this.blurRadius = 30,
    this.spreadRadius = 1,
    this.tlColor = Colors.blue,
    this.trColor = Colors.red,
    this.brColor = Colors.yellow,
    this.blColor = Colors.green,
    this.glowOpacity = 0.3,
    this.duration = const Duration(seconds: 2),
    this.thickness = 3.0,
    this.child,
    required this.controller,
  });

  final double radius;
  final double blurRadius;
  final double spreadRadius;
  final Color tlColor;
  final Color trColor;
  final Color brColor;
  final Color blColor;
  final double glowOpacity;
  final Duration duration;
  final double thickness;
  final Widget? child;
  final AnimationController controller;

  @override
  State<AnimatedBorderGradient> createState() => _AnimatedBorderGradientState();
}

class _AnimatedBorderGradientState extends State<AnimatedBorderGradient>
    with SingleTickerProviderStateMixin {
  late final Animation<Alignment> _tlAlignAnim;
  late final Animation<Alignment> _brAlignAnim;
  late final Animation<Alignment> _trAlignAnim;
  late final Animation<Alignment> _blAlignAnim;

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: widget.duration,
    // );

    final tweenSequence = (Alignment begin, Alignment end) =>
        TweenSequence<Alignment>([
          TweenSequenceItem(tween: Tween(begin: begin, end: end), weight: 1),
          TweenSequenceItem(tween: Tween(begin: end, end: begin), weight: 1),
        ]).animate(widget.controller);

    _tlAlignAnim = tweenSequence(Alignment.topLeft, Alignment.topRight);
    _brAlignAnim = tweenSequence(Alignment.bottomRight, Alignment.bottomLeft);
    _trAlignAnim = tweenSequence(Alignment.topRight, Alignment.bottomRight);
    _blAlignAnim = tweenSequence(Alignment.bottomLeft, Alignment.topLeft);

    widget.controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final decoration = (Color color) =>
            BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(widget.glowOpacity),
                  offset: Offset(0, 0),
                  blurRadius: widget.blurRadius,
                  spreadRadius: widget.spreadRadius,
                ),
              ],
            );

        return Stack(
          children: [
            if (widget.child != null) widget.child!,
            ClipPath(
              clipper: _CenterCutPath(
                  radius: widget.radius, thickness: widget.thickness),
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  return Stack(
                    children: [
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        decoration: decoration(widget.tlColor),
                      ),
                      Align(
                        alignment: _trAlignAnim.value,
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          decoration: decoration(widget.trColor),
                        ),
                      ),
                      Align(
                        alignment: _brAlignAnim.value,
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          decoration: decoration(widget.brColor),
                        ),
                      ),
                      Align(
                        alignment: _blAlignAnim.value,
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          decoration: decoration(widget.blColor),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(widget.radius)),
                          gradient: LinearGradient(
                            begin: _tlAlignAnim.value,
                            end: _brAlignAnim.value,
                            colors: [
                              widget.tlColor,
                              widget.trColor,
                              widget.brColor,
                              widget.blColor,
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CenterCutPath extends CustomClipper<Path> {
  final double radius;
  final double thickness;

  const _CenterCutPath({
    this.radius = 0,
    this.thickness = 1,
  });

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(
        -size.width, -size.width, size.width * 2, size.height * 2);
    final double width = size.width - thickness * 2;
    final double height = size.height - thickness * 2;

    return Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(thickness, thickness, width, height),
        Radius.circular(radius - thickness),
      ))
      ..addRect(rect);
  }

  @override
  bool shouldReclip(covariant _CenterCutPath oldClipper) {
    return oldClipper.radius != radius || oldClipper.thickness != thickness;
  }
}

// import 'package:flutter/material.dart';
//
// class AnimatedBorderGradient extends StatefulWidget {
//   const AnimatedBorderGradient(
//       {super.key,
//       this.radius = 200,
//       this.blurRadius = 30,
//       this.spreadRadius = 1,
//       this.tlColor = Colors.blue,
//       this.trColor = Colors.red,
//       this.brColor = Colors.yellow,
//       this.blColor = Colors.green,
//       this.glowOpacity = 0.3,
//       this.duration = const Duration(seconds: 2),
//       this.thickness = 3.0,
//       this.child});
//
//   final double radius;
//   final double blurRadius;
//   final double spreadRadius;
//   final Color tlColor;
//   final Color trColor;
//   final Color brColor;
//   final Color blColor;
//   final double glowOpacity;
//   final Duration duration;
//   final double thickness;
//   final Widget? child;
//
//   @override
//   State<AnimatedBorderGradient> createState() => _AnimatedBorderGradientState();
// }
//
// class _AnimatedBorderGradientState extends State<AnimatedBorderGradient>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Alignment> _tlAlignAnim;
//   late Animation<Alignment> _brAlignAnim;
//   late Animation<Alignment> _trAlignAnim;
//   late Animation<Alignment> _blAlignAnim;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.duration,
//     );
//
//
//     _tlAlignAnim = TweenSequence<Alignment>([
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topLeft, end: Alignment.topRight),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topRight, end: Alignment.bottomRight),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomRight, end: Alignment.bottomLeft),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomLeft, end: Alignment.topLeft),
//           weight: 1),
//     ]).animate(_controller);
//
//     _brAlignAnim = TweenSequence<Alignment>([
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomRight, end: Alignment.bottomLeft),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomLeft, end: Alignment.topLeft),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topLeft, end: Alignment.topRight),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topRight, end: Alignment.bottomRight),
//           weight: 1),
//     ]).animate(_controller);
//
//     _trAlignAnim = TweenSequence<Alignment>([
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topRight, end: Alignment.bottomRight),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomRight, end: Alignment.bottomLeft),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomLeft, end: Alignment.topLeft),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topLeft, end: Alignment.topRight),
//           weight: 1),
//     ]).animate(_controller);
//
//     _blAlignAnim = TweenSequence<Alignment>([
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomLeft, end: Alignment.topLeft),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topLeft, end: Alignment.topRight),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.topRight, end: Alignment.bottomRight),
//           weight: 1),
//       TweenSequenceItem(
//           tween: Tween<Alignment>(
//               begin: Alignment.bottomRight, end: Alignment.bottomLeft),
//           weight: 1),
//     ]).animate(_controller);
//
//     _controller.repeat();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Stack(
//           children: [
//             widget.child!,
//             ClipPath(
//               clipper: _CenterCutPath(
//                   radius: widget.radius, thickness: widget.thickness),
//               child: AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, _) {
//                     return Stack(children: [
//                       Container(
//                         width: constraints.maxWidth,
//                         height: constraints.maxHeight,
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(widget.radius)),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: widget.tlColor
//                                     .withOpacity(widget.glowOpacity),
//                                 offset: Offset(0, 0),
//                                 blurRadius: widget.blurRadius,
//                                 spreadRadius: widget.spreadRadius)
//                           ],
//                         ),
//                       ),
//                       Align(
//                         alignment: _trAlignAnim.value,
//                         child: Container(
//                           width: constraints.maxWidth,
//                           height: constraints.maxHeight,
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(widget.radius)),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: widget.trColor
//                                       .withOpacity(widget.glowOpacity),
//                                   offset: Offset(0, 0),
//                                   blurRadius: widget.blurRadius,
//                                   spreadRadius: widget.spreadRadius)
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: _brAlignAnim.value,
//                         child: Container(
//                           width: constraints.maxWidth,
//                           height: constraints.maxHeight,
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(widget.radius)),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: widget.brColor
//                                       .withOpacity(widget.glowOpacity),
//                                   offset: Offset(0, 0),
//                                   blurRadius: widget.blurRadius,
//                                   spreadRadius: widget.spreadRadius)
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: _blAlignAnim.value,
//                         child: Container(
//                           width: constraints.maxWidth,
//                           height: constraints.maxHeight,
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(widget.radius)),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: widget.blColor
//                                       .withOpacity(widget.glowOpacity),
//                                   offset: Offset(0, 0),
//                                   blurRadius: widget.blurRadius,
//                                   spreadRadius: widget.spreadRadius)
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(widget.radius)),
//                           gradient: LinearGradient(
//                             begin: _tlAlignAnim.value,
//                             end: _brAlignAnim.value,
//                             colors: [
//                               widget.tlColor,
//                               widget.trColor,
//                               widget.brColor,
//                               widget.blColor
//                             ],
//                           ),
//                         ),
//                       ),
//                     ]);
//                   }),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class _CenterCutPath extends CustomClipper<Path> {
//   final double radius;
//   final double thickness;
//
//   _CenterCutPath({
//     this.radius = 0,
//     this.thickness = 1,
//   });
//
//   @override
//   Path getClip(Size size) {
//     final rect = Rect.fromLTRB(
//         -size.width, -size.width, size.width * 2, size.height * 2);
//     final double width = size.width - thickness * 2;
//     final double height = size.height - thickness * 2;
//
//     final path = Path()
//       ..fillType = PathFillType.evenOdd
//       ..addRRect(RRect.fromRectAndRadius(
//         Rect.fromLTWH(thickness, thickness, width, height),
//         Radius.circular(radius - thickness),
//       ))
//       ..addRect(rect);
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant _CenterCutPath oldClipper) {
//     return oldClipper.radius != radius || oldClipper.thickness != thickness;
//   }
// }
