import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/values.dart';
import '../widgets/track_product_timeline_item.dart';

class RouteOrderDetailModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TEXT_WHITE,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RADIUS),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: BASE_PADDING),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  color: TEXT_SECONDARY_LIGHT,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: BASE_PADDING),
          Text(
            "Route Checkpoints",
            style: TextStyle(
              color: TEXT_BLUE,
              fontSize: DETAILS_TEXT,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "List of all checkpoint in this routes.",
            style: TextStyle(
              color: TEXT_BLACK,
              fontSize: DETAILS_TEXT,
              fontWeight: FontWeight.w500,
              height: 2,
            ),
          ),
          SizedBox(height: BASE_PADDING),
          TrackProductTimelineItem(
            title: 'Koteshwor, Bagmati, Nepal',
            isStart: true,
            done: true,
          ),
          TrackProductTimelineItem(
            title: 'Baneshwor, Bagmati, Nepal',
            done: true,
          ),
          TrackProductTimelineItem(
            title: 'Ratnapark, Bagmati, Nepal',
          ),
          TrackProductTimelineItem(
            title: 'Jamal, Bagmati, Nepal',
            isEnd: true,
          ),
          SizedBox(height: BASE_PADDING),
        ],
      ),
    );
  }
}
