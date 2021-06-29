import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTab;

  CustomButton({required this.title, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: colors.BUTTON_BLUE,
        padding: EdgeInsets.symmetric(vertical: values.BASE_PADDING + 4.0),
        visualDensity: VisualDensity.comfortable,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(values.RADIUS),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: colors.TEXT_WHITE,
              fontSize: values.BUTTON_TEXT,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      onPressed: onTab,
    );
  }
}
