import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/values.dart';

class OrderTypeBar extends StatelessWidget {
  final bool selected;
  final String title;
  final VoidCallback onTab;

  OrderTypeBar({
    this.selected = false,
    required this.onTab,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Material(
        borderRadius: BorderRadius.circular(RADIUS),
        color: selected ? BUTTON_BLUE : FIELD_BACKGROUND,
        child: InkWell(
          onTap: onTab,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(BASE_PADDING),
              child: Text(
                title,
                style: TextStyle(
                  color: selected ? TEXT_WHITE : TEXT_BLUE,
                  fontSize: TITLE_TEXT,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
