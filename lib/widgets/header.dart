import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class Header extends StatelessWidget {
  final String title;
  final bool backButton;
  final Widget? trailing;

  const Header({
    Key? key,
    required this.title,
    this.backButton = false,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (backButton)
          IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.chevron_left,
              color: colors.TEXT_BLUE,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 28),
          ),
        Padding(
          padding: EdgeInsets.all(!backButton ? 16.0 : 0),
          child: Text(
            title,
            style: TextStyle(
              color: colors.TEXT_BLUE,
              fontSize: values.SUB_HEADER_TEXT,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ),
        Expanded(child: Container()),
        trailing ?? Container(),
      ],
    );
  }
}
