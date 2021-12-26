import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType type;
  final List<TextInputFormatter> formatters;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? onSuffixTab;
  final bool enabled;
  final int? maxLines;
  final int? minLines;

  const CustomInput({
    Key? key,
    required this.controller,
    required this.hint,
    this.type = TextInputType.text,
    this.formatters = const [],
    this.validator,
    this.obscureText = false,
    this.icon,
    this.onSuffixTab,
    this.enabled = true,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(values.RADIUS),
          borderSide: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(values.RADIUS),
          borderSide: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(values.RADIUS),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        fillColor: colors.FIELD_BACKGROUND,
        filled: true,
        focusColor: colors.TEXT_SECONDARY,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(values.RADIUS),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: colors.TEXT_SECONDARY,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        suffixIcon: icon != null
            ? IconButton(
                onPressed: onSuffixTab,
                icon: Icon(icon),
                color: colors.TEXT_BLUE,
              )
            : null,
      ),
      style: TextStyle(
        color: colors.TEXT_BLACK,
        fontWeight: FontWeight.w600,
        height: 1.5,
      ),
      maxLines: !obscureText ? maxLines : 1,
      minLines: !obscureText ? minLines : 1,
      enableSuggestions: true,
      inputFormatters: formatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: type,
      obscureText: obscureText,
      controller: controller,
    );
  }
}
