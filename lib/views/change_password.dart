import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/values.dart' as values;
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/header.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(
              backButton: true,
              title: 'Change Password',
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: values.BASE_PADDING),
                      CustomInput(
                        hint: "Old Password",
                        obscureText: !_showOldPassword,
                        controller: _oldPassword,
                        validator: (v) {
                          if ((v as String).isEmpty) {
                            return 'Please enter old password';
                          }
                          return null;
                        },
                        icon: _showOldPassword
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill,
                        onSuffixTab: () {
                          _showOldPassword = !_showOldPassword;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: values.BASE_PADDING),
                      CustomInput(
                        hint: "New Password",
                        obscureText: !_showNewPassword,
                        controller: _newPassword,
                        validator: (v) {
                          if ((v as String).isEmpty) {
                            return 'Please enter new password';
                          }
                          return null;
                        },
                        icon: _showNewPassword
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill,
                        onSuffixTab: () {
                          _showNewPassword = !_showNewPassword;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: values.BASE_PADDING),
                      CustomInput(
                        hint: "Confirm Password",
                        obscureText: !_showConfirmPassword,
                        controller: _confirmPassword,
                        validator: (v) {
                          if ((v as String) != _newPassword.text) {
                            return 'Password don not match';
                          }
                          return null;
                        },
                        icon: _showConfirmPassword
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill,
                        onSuffixTab: () {
                          _showConfirmPassword = !_showConfirmPassword;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: values.BASE_PADDING),
                      const SizedBox(height: values.BASE_PADDING * 1.5),
                      SizedBox(
                        height: 58.0,
                        child: CustomButton(
                          title: "Change",
                          onTab: _update,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _update() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // if (_name.text.isEmpty) {
    //   showBottomDialog(
    //     context: context,
    //     dialogType: DialogType.ERROR,
    //     title: 'ERROR!',
    //     message: 'Please enter name',
    //   );
    //   return;
    // }
    // if (_phone.text.isEmpty) {
    //   showBottomDialog(
    //     context: context,
    //     dialogType: DialogType.ERROR,
    //     title: 'ERROR!',
    //     message: 'Please enter mobile number',
    //   );
    //   return;
    // }
    // if (!isEmail(_email.text)) {
    //   showBottomDialog(
    //     context: context,
    //     dialogType: DialogType.ERROR,
    //     title: 'ERROR!',
    //     message: 'Please enter valid email',
    //   );
    //   return;
    // }
    //
    // var progressDialog = getProgressDialog(context: context);
    // progressDialog.show(useSafeArea: false);
    //
    // var result = await context.read<AuthenticationController>().updateProfile(
    //       name: _name.text,
    //       email: _email.text,
    //       phone: _phone.text.replaceAll(' ', ''),
    //     );
    //
    // progressDialog.dismiss();
    //
    // if (result) {
    //   showBottomDialog(
    //     context: context,
    //     dialogType: DialogType.SUCCESS,
    //     title: 'Update Successfully',
    //     message: 'Your profile is updated successfully.',
    //   );
    // } else {
    //   showBottomDialog(
    //     context: context,
    //     dialogType: DialogType.ERROR,
    //     title: 'Update Error',
    //   );
    // }
  }
}
