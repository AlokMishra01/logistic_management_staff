import 'package:flutter/material.dart';

class Constants{

  static Color theme_color=_colorFromHex("#46699E");
  static Color unselected=_colorFromHex("#858383");
  static Color grey_bg=_colorFromHex("#EFEEEE");
  static Color green_bg=_colorFromHex("#E3EFDE");
  static Color blue_bg=_colorFromHex("#CCE3F9");
  static Color greenBtn=_colorFromHex("#0D9E1C");
  static Color greyish_white=_colorFromHex("#EFEFEF");
  static Color red=_colorFromHex("#FF6969");
  static Color tilebg=_colorFromHex("F9F9F9");

  static TextStyle formTitle=new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 36,
    color: theme_color,
    letterSpacing: -0.015
  );

  static TextStyle pageTitle=new TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: theme_color
  );

  static TextStyle todaystyle=new TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,

  );

  static TextStyle commonstyle=new TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Colors.black
  );

  static String api_key="AIzaSyCaxnzjztsotM_o493_qxQwqFrlLlgwuYM";



}

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

