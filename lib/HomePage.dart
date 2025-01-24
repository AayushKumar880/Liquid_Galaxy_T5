import 'package:flutter/material.dart';
import 'package:progress_bar/CustomTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: Semantics(
          label: 'Progress Bar Screen',
          child: Text('Progress Bar'),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Semantics(
        label: 'Order Progress Tracker',
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              Semantics(
                label: 'Cart step',
                value: 'First step in checkout process',
                child: const CustomTimelineTile(
                  isFirst: true,
                  eventName: 'Cart',
                ),
              ),
              Semantics(
                label: 'Address step',
                value: 'Second step in checkout process',
                child: const CustomTimelineTile(
                  eventName: 'Address',
                ),
              ),
              Semantics(
                label: 'Payment step',
                value: 'Third step in checkout process',
                child: const CustomTimelineTile(
                  eventName: 'Payment',
                ),
              ),
              Semantics(
                label: 'Checkout step',
                value: 'Final step in checkout process',
                child: const CustomTimelineTile(
                  isLast: true,
                  eventName: 'Checkout',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}