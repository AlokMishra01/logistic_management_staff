import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logistic_management_staff/controllers/authentication_controller.dart';
import 'package:logistic_management_staff/views/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';

enum DialogType {
  simple,
  logout,
  appClose,
}

class CustomDialogs {
  static CustomDialogs dialogs = CustomDialogs();

  showCustomDialog({
    required BuildContext context,
    String? title,
    String? message,
    DialogType type = DialogType.simple,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 60.0,
                  right: 12.0,
                  bottom: 12.0,
                ),
                margin: const EdgeInsets.only(top: 48.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: TEXT_WHITE,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: BLUE_BACKGROUND.withOpacity(0.4),
                      offset: const Offset(0, 12),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: _buildDialogBody(
                  type: type,
                  title: title,
                  message: message,
                ),
              ),
              const Positioned(
                left: 16.0,
                right: 16.0,
                child: CircleAvatar(
                  backgroundColor: BUTTON_BLUE,
                  radius: 48.0,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundColor: TEXT_WHITE,
                      radius: 44.0,
                      backgroundImage: AssetImage(
                        'images/icon.png',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildDialogBody({required DialogType type, String? title, String? message}) {
    switch (type) {
      case DialogType.simple:
        return _SimpleDialog(
          title: title ?? '',
          message: message ?? '',
        );
      case DialogType.logout:
        return const _LogoutDialog();
      case DialogType.appClose:
        return const _AppCloseDialog();
    }
  }
}

class _SimpleDialog extends StatelessWidget {
  final String title;
  final String message;

  const _SimpleDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: TEXT_BLACK,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: TEXT_SECONDARY,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 12.0),
          Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: BUTTON_BLUE,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: const Text(
                'Okay',
                style: TextStyle(
                  color: TEXT_WHITE,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: TEXT_SECONDARY,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: TEXT_WHITE,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(
                      color: BUTTON_BLUE,
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: BUTTON_BLUE,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                MaterialButton(
                  onPressed: () async {
                    context.read<AuthenticationController>().logOut();
                    SharedPreferences s = await SharedPreferences.getInstance();
                    await s.clear();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()),
                      (route) => false,
                    );
                  },
                  color: RED,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: TEXT_WHITE,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppCloseDialog extends StatelessWidget {
  const _AppCloseDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Are you sure you want to exit this application?',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: TEXT_SECONDARY,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: TEXT_WHITE,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(
                      color: BUTTON_BLUE,
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: BUTTON_BLUE,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                MaterialButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  color: RED,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: TEXT_WHITE,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
