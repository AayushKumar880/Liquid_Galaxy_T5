import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BottomNavWithLottie extends StatefulWidget {
  const BottomNavWithLottie({Key? key}) : super(key: key);

  @override
  State<BottomNavWithLottie> createState() => _BottomNavWithLottieState();
}

class _BottomNavWithLottieState extends State<BottomNavWithLottie> {
  int _selectedIndex = 0;

  // List of Lottie assets for the bottom navigation bar
  final List<String> _lottieAssets = [
    'assets/animations/notification.json',
    'assets/animations/play.json',
    'assets/animations/user.json',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Bottom Bar'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Selected Index: $_selectedIndex',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.white,
        items: List.generate(_lottieAssets.length, (index) {
          return BottomNavigationBarItem(
            label: '', // Labels can be omitted if unnecessary
            icon: Lottie.asset(
              _lottieAssets[index],
              width: 48,
              height: 48,
              repeat: false, // Animation plays once when selected
              animate: _selectedIndex == index, // Play animation only if selected
            ),
          );
        }),
      ),
    );
  }
}
