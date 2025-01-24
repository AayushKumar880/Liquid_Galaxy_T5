import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  bool enableAnim1 = false;
  bool enableAnim2 = false;
  bool enableAnim3 = false;

  @override
  void initState() {
    super.initState();

    _controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller3 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  void toggleAnimation(int index) {
    setState(() {
      if (index == 1) {
        enableAnim1 = !enableAnim1;
        enableAnim1 ? _controller1.repeat() : _controller1.reset();
        enableAnim2 = false;
        enableAnim3 = false;
        _controller2.reset();
        _controller3.reset();
      } else if (index == 2) {
        enableAnim1 = false;
        enableAnim2 = !enableAnim2;
        enableAnim2 ? _controller2.repeat() : _controller2.reset();
        enableAnim3 = false;
        _controller1.reset();
        _controller3.reset();
      } else if (index == 3) {
        enableAnim1 = false;
        enableAnim2 = false;
        enableAnim3 = !enableAnim3;
        enableAnim3 ? _controller3.repeat() : _controller3.reset();
        _controller1.reset();
        _controller2.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          label: 'Lottie Animated Icons Screen',
          child: const Text(
            'Lottie Animated Icons',
            style: TextStyle(fontSize: 24),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: Semantics(
        label: 'Navigation Bar',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Divider(
              height: 1,
              color: Colors.grey,
              thickness: 1,
            ),
            Material(
              elevation: 16.0,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.black12,
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLottieIcon(
                        1,
                        'assets/animations/notification.json',
                        _controller1,
                        enableAnim1,
                        'Notification'),
                    _buildLottieIcon(2, 'assets/animations/play.json',
                        _controller2, enableAnim2, 'Play'),
                    _buildLottieIcon(3, 'assets/animations/user.json',
                        _controller3, enableAnim3, 'User Profile'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Semantics(
        label: 'Main Content',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Semantics(
                  label: 'Favorite',
                  child: Icon(Icons.favorite),
                ),
                Semantics(
                  label: 'Star',
                  child: Icon(Icons.star),
                ),
                Semantics(
                  label: 'Account',
                  child: Icon(Icons.account_box_outlined),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLottieIcon(int index, String assetPath,
      AnimationController controller, bool isActive, String semanticLabel) {
    return Semantics(
      button: true,
      label: semanticLabel,
      value: isActive ? 'Active' : 'Inactive',
      hint: 'Double tap to ${isActive ? 'stop' : 'start'} animation',
      child: GestureDetector(
        onTap: () => toggleAnimation(index),
        child: SizedBox(
          height: 48,
          width: 48,
          child: Lottie.asset(
            assetPath,
            controller: controller,
            repeat: true,
            animate: isActive,
          ),
        ),
      ),
    );
  }
}