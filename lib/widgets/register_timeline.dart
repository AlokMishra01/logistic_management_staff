import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/values.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RegisterTimeline extends StatelessWidget {
  final bool isStart;
  final bool isEnd;
  final bool done;

  const RegisterTimeline({
    Key? key,
    this.isStart = false,
    this.isEnd = false,
    this.done = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      axis: TimelineAxis.horizontal,
      isFirst: isStart,
      isLast: isEnd,
      afterLineStyle: LineStyle(color: BUTTON_BLUE, thickness: 4),
      beforeLineStyle: LineStyle(color: BUTTON_BLUE, thickness: 4),
      indicatorStyle: IndicatorStyle(
        color: BUTTON_BLUE,
        width: 20,
        indicator: CircleAvatar(
          backgroundColor: BUTTON_BLUE,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 8,
              backgroundColor: done ? BUTTON_BLUE : TEXT_WHITE,
            ),
          ),
        ),
      ),
    );
  }
}
