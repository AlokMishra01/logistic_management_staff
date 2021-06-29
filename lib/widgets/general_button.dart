import 'package:flutter/material.dart';
import 'package:logistic_management_staff/constants/values.dart';

class GeneralButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onTab;

  const GeneralButton({
    Key? key,
    required this.color,
    required this.child,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTab,
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RADIUS / 2),
      ),
      child: child,
    );
  }
}
