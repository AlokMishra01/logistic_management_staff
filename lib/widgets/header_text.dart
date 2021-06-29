import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class HeaderText extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onIconTab;

  const HeaderText({
    Key? key,
    required this.text,
    required this.icon,
    required this.onIconTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: values.HEADER_TEXT,
            color: colors.TEXT_BLUE,
          ),
        ),
        IconButton(
          onPressed: onIconTab,
          icon: Icon(icon),
          iconSize: values.HEADER_TEXT,
          color: colors.BUTTON_BLUE,
        ),
      ],
    );
  }
}
