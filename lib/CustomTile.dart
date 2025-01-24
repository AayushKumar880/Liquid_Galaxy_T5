import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'EventCard.dart';

class CustomTimelineTile extends StatefulWidget {
  const CustomTimelineTile({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    required this.eventName,
  });

  final bool isFirst;
  final bool isLast;
  final String eventName;

  @override
  State<CustomTimelineTile> createState() => _CustomTimelineTileState();
}

class _CustomTimelineTileState extends State<CustomTimelineTile> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        isFirst: widget.isFirst,
        isLast: widget.isLast,
        beforeLineStyle: LineStyle(
          color: isCompleted ? Colors.deepPurple : Colors.deepPurple.shade200,
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isCompleted ? Colors.deepPurple : Colors.deepPurple.shade200,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: isCompleted ? Colors.white : Colors.deepPurple.shade100,
          ),
        ),
        endChild: GestureDetector(
          child:
              Eventcard(eventName: widget.eventName, isCompleted: isCompleted),
          onTap: () {
            setState(() {
              isCompleted = !isCompleted;
            });
          },
        ),
      ),
    );
    ;
  }
}
