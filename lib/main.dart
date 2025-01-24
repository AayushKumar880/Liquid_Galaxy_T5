import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homepage.dart';

void main() {
  runApp(const VoiceUI());
}

class VoiceUI extends StatelessWidget {
  const VoiceUI({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Homepage(),
    );
  }
}
