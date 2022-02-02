import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class ProfileDetailRow extends StatelessWidget {
  final String title;
  final String value;

  const ProfileDetailRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: values.BASE_PADDING,
        vertical: values.BASE_PADDING / 2,
      ),
      child: RichText(
        text: TextSpan(
          text: '$title : ',
          style: GoogleFonts.comfortaa(
            fontSize: values.TITLE_TEXT,
            color: colors.TEXT_SECONDARY,
          ),
          children: [
            TextSpan(
              text: value,
              style: GoogleFonts.comfortaa(
                fontSize: values.TITLE_TEXT,
                color: colors.TEXT_BLACK,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
