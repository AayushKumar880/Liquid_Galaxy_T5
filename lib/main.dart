import 'package:flutter/material.dart';

import 'GeminiLogo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black, // Dark background
        body: Center(
          child: AnimatedLogo(),
        ),
      ),
    );
  }
}
