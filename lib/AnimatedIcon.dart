// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class AnimatedButton extends StatefulWidget {
//   const AnimatedButton({super.key});
//
//   @override
//   _AnimatedButtonState createState() => _AnimatedButtonState();
// }
//
// class _AnimatedButtonState extends State<AnimatedButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _rotateAnimation;
//   late Animation<double> _brightnessAnimation;
//   late Animation<Color?> _gradientAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     )..repeat();
//
//     _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//
//     _rotateAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.linear),
//     );
//
//     _brightnessAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//
//     _gradientAnimation = ColorTween(
//       begin: Colors.blue,
//       end: Colors.purple,
//     ).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             // Add functionality
//           },
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   return Transform.rotate(
//                     angle: _rotateAnimation.value,
//                     child: Container(
//                       width: 243,
//                       height: 243,
//                       decoration: BoxDecoration(
//                         gradient: RadialGradient(
//                           colors: [
//                             _gradientAnimation.value ?? Colors.blue ,
//                             Colors.blue.withOpacity(0.6),
//                             Colors.purple.withOpacity(0.4),
//                           ],
//                           stops: const [0.3, 0.6, 1],
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Transform.rotate(
//                       angle: _controller.value * pi,
//                       child: Icon(
//                         Icons.ac_unit, // Replace with your gemini icon
//                         size: 80,
//                         color: Colors.white
//                             .withOpacity(_brightnessAnimation.value),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
