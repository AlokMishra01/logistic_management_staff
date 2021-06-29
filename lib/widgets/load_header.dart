import 'package:flutter/material.dart';
import 'package:logistic_management_staff/constants/colors.dart';
import 'package:logistic_management_staff/constants/values.dart';

class LoadHeader extends StatelessWidget {
  final String title;
  final String value;

  const LoadHeader({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: TEXT_WHITE,
              fontSize: TITLE_TEXT - 4,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: TEXT_WHITE,
              fontSize: TITLE_TEXT + 4,
              height: 1.5,
            ),
          )
        ],
      ),
    );
  }
}
