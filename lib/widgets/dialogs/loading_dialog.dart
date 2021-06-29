import 'package:ars_dialog/ars_dialog.dart';

CustomProgressDialog getProgressDialog({required context}) {
  return CustomProgressDialog(
    context,
    blur: 2,
    dialogTransitionType: DialogTransitionType.Bubble,
    dismissable: false,
  );
}
