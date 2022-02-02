import 'package:flutter/material.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class ProfileInfoHeading extends StatelessWidget {
  final String title;
  final VoidCallback? onTab;

  const ProfileInfoHeading({
    Key? key,
    required this.title,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(
      //   horizontal: values.BASE_PADDING,
      //   vertical: values.BASE_PADDING,
      // ),
      decoration: const BoxDecoration(
        color: colors.FIELD_BACKGROUND,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: values.BASE_PADDING,
              vertical: values.BASE_PADDING,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: values.DETAILS_TEXT + 2,
                fontWeight: FontWeight.bold,
                color: colors.TEXT_BLUE,
                height: 1.25,
              ),
            ),
          ),
          onTab == null
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: onTab,
                  icon: const Icon(
                    Icons.edit_rounded,
                    color: colors.TEXT_BLUE,
                    size: 20.0,
                  ),
                  visualDensity: VisualDensity.standard,
                ),
        ],
      ),
    );
  }
}
