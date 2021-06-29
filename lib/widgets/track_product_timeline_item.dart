import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class TrackProductTimelineItem extends StatelessWidget {
  final bool isStart;
  final bool isEnd;
  final bool done;
  final String title;

  const TrackProductTimelineItem({
    Key? key,
    this.isStart = false,
    this.isEnd = false,
    this.done = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      isFirst: isStart,
      isLast: isEnd,
      indicatorStyle: IndicatorStyle(
        color: colors.BUTTON_BLUE,
        width: values.DETAILS_TEXT,
        padding: EdgeInsets.zero,
        indicator: CircleAvatar(
          backgroundColor: colors.BUTTON_BLUE,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 6,
              backgroundColor: done ? colors.BUTTON_BLUE : colors.TEXT_WHITE,
            ),
          ),
        ),
      ),
      afterLineStyle: LineStyle(color: colors.BUTTON_BLUE, thickness: 2),
      beforeLineStyle: LineStyle(color: colors.BUTTON_BLUE, thickness: 2),
      lineXY: 0.1,
      endChild: Container(
        padding: const EdgeInsets.symmetric(
          vertical: values.BASE_PADDING / 4,
          horizontal: values.BASE_PADDING / 2,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.FIELD_BACKGROUND.withOpacity(0.5),
            borderRadius: BorderRadius.circular(
              40,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: values.BASE_PADDING / 2),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: values.DETAILS_TEXT,
                    color: done ? colors.TEXT_BLUE : colors.TEXT_SECONDARY,
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(width: values.BASE_PADDING / 2),
              TextButton(
                onPressed: () {},
                child: Text(
                  'VIEW',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: colors.TEXT_BLUE,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: colors.FIELD_BACKGROUND,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.zero,
                ),
              )
            ],
          ),
        ),
      ),
      startChild: Container(),
    );
  }
}
