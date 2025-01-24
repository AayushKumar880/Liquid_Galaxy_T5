import 'package:flutter/material.dart';

class TabBarEffect extends StatefulWidget {
  const TabBarEffect({super.key});

  @override
  State<TabBarEffect> createState() => _TabBarEffectState();
}

class _TabBarEffectState extends State<TabBarEffect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(seconds: 2),
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'Tab Bar Effect Screen',
            child: const Text('Tab Bar Effect'),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Semantics(
                label: 'Home tab',
                hint: 'Navigate to home screen',
                child: const Tab(
                  icon: Icon(Icons.home),
                ),
              ),
              Semantics(
                label: 'Settings tab',
                hint: 'Navigate to settings screen',
                child: const Tab(
                  icon: Icon(Icons.settings),
                ),
              ),
              Semantics(
                label: 'My Tasks tab',
                hint: 'Navigate to tasks screen',
                child: const Tab(
                  text: 'My Tasks',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}