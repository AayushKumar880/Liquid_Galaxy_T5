import 'package:flutter/material.dart';

class Eventcard extends StatelessWidget {
  const Eventcard({
    super.key,
    required this.eventName,
    required this.isCompleted,
  });

  final String eventName;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.deepPurple.shade300
            : Colors.deepPurple.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            eventName,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isCompleted ? Colors.white : Colors.deepPurple.shade600),
          ),
          Text(
            isCompleted ? 'Completed' : 'Pending',
            style: TextStyle(
                fontSize: 12,
                color: isCompleted ? Colors.white : Colors.deepPurple.shade600),
          ),
        ],
      ),
    );
  }
}
