import 'package:flutter/material.dart';
import 'package:logistic_management_staff/constants/enums.dart';
import 'package:logistic_management_staff/controllers/authentication_controller.dart';
import 'package:logistic_management_staff/widgets/custom_button.dart';
import 'package:logistic_management_staff/widgets/custom_input.dart';
import 'package:logistic_management_staff/widgets/dialogs/bottom_dialog.dart';
import 'package:logistic_management_staff/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../constants/values.dart' as values;
import '../widgets/header.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthenticationController>();
    _name.text = auth.userModel?.name ?? '';
    _phone.text = auth.userModel?.phone ?? '';
    _email.text = auth.userModel?.email ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
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
              title: 'Update Profile',
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
                        hint: "Name",
                        controller: _name,
                        validator: (value) {
                          if ((value as String).isEmpty) {
                            return 'Please enter name';
                          }
                        },
                      ),
                      const SizedBox(height: values.BASE_PADDING),
                      CustomInput(
                        hint: "Mobile Number",
                        controller: _phone,
                        type: TextInputType.phone,
                        // formatters: [
                        //   PhoneInputFormatter(allowEndlessPhone: false),
                        // ],
                        validator: (value) {
                          // if (!isPhoneValid(value as String))
                          //   return 'Please enter valid mobile number';
                          if ((value as String).isEmpty) {
                            return 'Please enter mobile number';
                          }
                        },
                      ),
                      const SizedBox(height: values.BASE_PADDING),
                      CustomInput(
                        hint: "Email",
                        controller: _email,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (!isEmail(value as String)) {
                            return 'Please enter valid email';
                          }
                        },
                      ),
                      const SizedBox(height: values.BASE_PADDING),
                      const SizedBox(height: values.BASE_PADDING * 1.5),
                      SizedBox(
                        height: 58.0,
                        child: CustomButton(
                          title: "UPDATE",
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
    if (_name.text.isEmpty) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'ERROR!',
        message: 'Please enter name',
      );
      return;
    }
    if (_phone.text.isEmpty) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'ERROR!',
        message: 'Please enter mobile number',
      );
      return;
    }
    if (!isEmail(_email.text)) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'ERROR!',
        message: 'Please enter valid email',
      );
      return;
    }

    var progressDialog = getProgressDialog(context: context);
    progressDialog.show(useSafeArea: false);

    var result = await context.read<AuthenticationController>().updateProfile(
          name: _name.text,
          email: _email.text,
          phone: _phone.text.replaceAll(' ', ''),
        );

    progressDialog.dismiss();

    if (result) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.SUCCESS,
        title: 'Update Successfully',
        message: 'Your profile is updated successfully.',
      );
    } else {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'Update Error',
      );
    }
  }
}
