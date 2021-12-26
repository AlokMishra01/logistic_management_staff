import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart' as colors;
import '../constants/enums.dart';
import '../constants/values.dart' as values;
import '../controllers/authentication_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/dialogs/bottom_dialog.dart';
import '../widgets/dialogs/loading_dialog.dart';
import '../widgets/header_text.dart';
import 'main_page.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: values.BASE_PADDING,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeaderText(
                    text: 'Login',
                    icon: CupertinoIcons.square_arrow_right,
                    onIconTab: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (cxt) => Register()),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                CustomInput(
                  hint: "Mobile Number",
                  controller: _phone,
                  type: TextInputType.phone,
                  // formatters: [
                  //   PhoneInputFormatter(allowEndlessPhone: false),
                  // ],
                  validator: (v) {
                    // if (!isPhoneValid(v as String)) {
                    //   return 'Please enter valid mobile number';
                    // }
                    if ((v as String).isEmpty) {
                      return 'Please enter mobile number';
                    }
                  },
                ),
                SizedBox(height: values.BASE_PADDING),
                CustomInput(
                  hint: "Password",
                  obscureText: !_showPassword,
                  controller: _password,
                  validator: (v) {
                    if ((v as String).isEmpty) {
                      return 'Please enter password';
                    }
                  },
                  icon: _showPassword
                      ? CupertinoIcons.eye_slash_fill
                      : CupertinoIcons.eye_fill,
                  onSuffixTab: () {
                    _showPassword = !_showPassword;
                    setState(() {});
                  },
                ),
                SizedBox(height: values.BASE_PADDING / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: colors.TEXT_BLUE,
                          fontSize: values.BUTTON_TEXT,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: values.BASE_PADDING / 2),
                // CustomButton(title: 'LOGIN', onTab: _login),
                CustomButton(
                  title: 'LOGIN',
                  onTab: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_phone.text.length != 10) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'ERROR!',
        message: 'Mobile number should have 10 numbers.',
      );
      return;
    }
    if (_password.text.length < 6) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'ERROR!',
        message: 'Password should have 6 characters.',
      );
      return;
    }
    final progressDialog = getProgressDialog(context: context);
    progressDialog.show(useSafeArea: false);

    String result = await context.read<AuthenticationController>().login(
          phone: _phone.text.replaceAll(' ', ''),
          password: _password.text,
        );

    progressDialog.dismiss();

    if (result.isEmpty) {
      showBottomDialog(
        context: context,
        dialogType: DialogType.SUCCESS,
        title: 'Login Success',
        message: 'You are successfully logged in.',
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => MainPage(),
        ),
        (route) => false,
      );
    } else {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'Login Error',
        message: result,
      );
    }
  }

  // _login() async {
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   if (!isPhoneValid(_phone.text)) {
  //     // showBottomDialog(
  //     //   context: context,
  //     //   dialogType: DialogType.ERROR,
  //     //   title: 'ERROR!',
  //     //   message: 'Please enter valid mobile number',
  //     // );
  //     return;
  //   }
  //   // if (_phone.text.isEmpty) {
  //   //   showBottomDialog(
  //   //     context: context,
  //   //     dialogType: DialogType.ERROR,
  //   //     title: 'ERROR!',
  //   //     message: 'Please enter mobile number',
  //   //   );
  //   //   return;
  //   // }
  //   if (_password.text.isEmpty) {
  //     // showBottomDialog(
  //     //   context: context,
  //     //   dialogType: DialogType.ERROR,
  //     //   title: 'ERROR!',
  //     //   message: 'Please enter password',
  //     // );
  //     return;
  //   }
  //
  //   var progressDialog = getProgressDialog(context: context);
  //   progressDialog.show(useSafeArea: false);
  //
  //   var loginResult = await context.read<AuthenticationController>().login(
  //         phone: _phone.text.replaceAll(' ', ''),
  //         password: _password.text,
  //       );
  //
  //   if (loginResult.isEmpty) {
  //     showBottomDialog(
  //       context: context,
  //       dialogType: DialogType.SUCCESS,
  //       title: 'Login Success',
  //       message: 'You are successfully logged in.',
  //     );
  //     // context.read<DeliveryProvider>().fetchDispatched(
  //     //       userId: context.read<AuthenticationProvider>().staff!.id ?? 1,
  //     //     );
  //     // context.read<PickUpProvider>().fetchPickUp(
  //     //       userId: context.read<AuthenticationProvider>().staff!.id ?? 1,
  //     //     );
  //     await Future.delayed(Duration(seconds: 1));
  //     progressDialog.dismiss();
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (_) => MainPage()),
  //       (route) => false,
  //     );
  //   } else {
  //     progressDialog.dismiss();
  //     showBottomDialog(
  //       context: context,
  //       dialogType: DialogType.ERROR,
  //       title: 'Login Error',
  //       message: loginResult,
  //     );
  //   }
  // }
}
