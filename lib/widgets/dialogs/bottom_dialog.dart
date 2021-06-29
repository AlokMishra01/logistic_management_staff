import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/values.dart' as values;
import '../../constants/colors.dart' as colors;
import '../../constants/enums.dart' as enums;

showBottomDialog({
  required BuildContext context,
  enums.DialogType dialogType = enums.DialogType.SUCCESS,
  String title = 'Successfully Completed',
  String message = 'Your request is successfully compleded.',
}) {
  showFlash(
    context: context,
    duration: Duration(seconds: 2),
    builder: (_, controller) {
      return Flash(
        controller: controller,
        margin: EdgeInsets.zero,
        behavior: FlashBehavior.fixed,
        position: FlashPosition.bottom,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(values.RADIUS),
        ),
        backgroundColor: colors.TEXT_WHITE,
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        child: DefaultTextStyle(
          style: TextStyle(
            color: colors.TEXT_SECONDARY,
            fontSize: values.DETAILS_TEXT,
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
          child: FlashBar(
            title: Text(
              title,
              style: TextStyle(
                color: _getDialogColor(dialogType),
                fontSize: values.TITLE_TEXT,
                fontWeight: FontWeight.bold,
                height: 1.25,
              ),
            ),
            content: Text(
              message,
            ),
            indicatorColor: _getDialogColor(dialogType),
            actions: <Widget>[
              TextButton(
                onPressed: () => controller.dismiss(),
                child: Text(
                  ' Okay ',
                  style: TextStyle(
                    color: colors.TEXT_WHITE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: _getDialogColor(dialogType),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(values.RADIUS),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Color _getDialogColor(enums.DialogType dialogType) {
  switch (dialogType) {
    case enums.DialogType.SUCCESS:
      return colors.BUTTON_GREEN;
    case enums.DialogType.INFO:
      return colors.BUTTON_BLUE;
    case enums.DialogType.WARNING:
      return colors.YELLOW;
    case enums.DialogType.ERROR:
      return colors.RED;
    default:
      return colors.TEXT_WHITE;
  }
}
