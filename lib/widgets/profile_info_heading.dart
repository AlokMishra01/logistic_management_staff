import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class ProfileInfoHeading extends StatelessWidget {
  final String title;

  const ProfileInfoHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: values.BASE_PADDING / 2,
        vertical: values.BASE_PADDING / 2,
      ),
      decoration: BoxDecoration(
        color: colors.FIELD_BACKGROUND,
      ),
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          fontSize: values.DETAILS_TEXT + 2,
          fontWeight: FontWeight.bold,
          color: colors.TEXT_BLUE,
          height: 1.25,
        ),
      ),
    );
  }
}
