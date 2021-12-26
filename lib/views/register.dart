import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/views/main_page.dart';
import 'package:logistic_management_staff/widgets/register_timeline.dart';
import 'package:validators/validators.dart';

import '../constants/values.dart' as values;
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/header_text.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Basic Info
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();

  // Vechile Info
  TextEditingController _registrationNo = TextEditingController();
  TextEditingController _brand = TextEditingController();
  TextEditingController _model = TextEditingController();
  TextEditingController _engineNo = TextEditingController();
  TextEditingController _color = TextEditingController();

  // Documents
  TextEditingController _license = TextEditingController();
  TextEditingController _file = TextEditingController();

  int _currentPage = 0;
  List<String> _headerTitle = ['Basic Info', 'Vechile Info', 'Documents'];
  List<String> _buttonTitle = ['NEXT', 'NEXT', 'FINISH'];

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _address.dispose();
    _registrationNo.dispose();
    _brand.dispose();
    _model.dispose();
    _engineNo.dispose();
    _color.dispose();
    _license.dispose();
    _file.dispose();
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
                SizedBox(height: (size.height * 0.1) - 32),
                Container(
                  height: 24,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RegisterTimeline(
                          isStart: true,
                          done: _currentPage >= 0,
                        ),
                        RegisterTimeline(done: _currentPage >= 1),
                        RegisterTimeline(
                          isEnd: true,
                          done: _currentPage >= 2,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeaderText(
                    text: _headerTitle[_currentPage],
                    icon: CupertinoIcons.person,
                    onIconTab: () {},
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                if (_currentPage == 0)
                  CustomInput(
                    hint: "Full Name",
                    type: TextInputType.name,
                    controller: _name,
                    validator: (value) {
                      if ((value as String).isEmpty)
                        return 'Please enter full name';
                    },
                  ),
                if (_currentPage == 1)
                  CustomInput(
                    hint: "Registration Number",
                    controller: _registrationNo,
                    validator: (value) {
                      if ((value as String).isEmpty)
                        return 'Please enter registration number';
                    },
                  ),
                if (_currentPage == 2)
                  CustomInput(
                    hint: "Vehicle License",
                    controller: _license,
                    validator: (value) {
                      if ((value as String).isEmpty)
                        return 'Please enter vehicle license';
                    },
                  ),
                SizedBox(height: values.BASE_PADDING),
                if (_currentPage == 0)
                  CustomInput(
                    hint: "Address",
                    controller: _address,
                    validator: (value) {
                      if ((value as String).isEmpty)
                        return 'Please enter address';
                    },
                  ),
                if (_currentPage == 1)
                  CustomInput(
                    hint: "Vehicle Brand",
                    controller: _brand,
                    validator: (value) {
                      if ((value as String).isEmpty)
                        return 'Please enter vehicle brand';
                    },
                  ),
                if (_currentPage == 2)
                  CustomInput(
                    hint: "",
                    controller: _file,
                    minLines: 4,
                    maxLines: 4,
                    // validator: (value) {
                    //   if ((value as String).isEmpty)
                    //     return 'Please enter address';
                    // },
                  ),
                SizedBox(height: values.BASE_PADDING),
                if (_currentPage == 0)
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
                if (_currentPage == 1)
                  CustomInput(
                    hint: "Vehicle Model",
                    controller: _model,
                    // formatters: [
                    //   PhoneInputFormatter(allowEndlessPhone: false),
                    // ],
                    validator: (value) {
                      // if (!isPhoneValid(value as String))
                      //   return 'Please enter valid mobile number';
                      if ((value as String).isEmpty) {
                        return 'Please enter vehicle model';
                      }
                    },
                  ),
                SizedBox(height: values.BASE_PADDING),
                if (_currentPage == 0)
                  CustomInput(
                    hint: "Email",
                    controller: _email,
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      if (!isEmail(value as String))
                        return 'Please enter valid email';
                    },
                  ),
                if (_currentPage == 1)
                  CustomInput(
                    hint: "Vehicle Engine Number",
                    controller: _engineNo,
                    validator: (value) {
                      if ((value as String).isEmpty)
                        return 'Please enter vehicle engine number';
                    },
                  ),
                if (_currentPage == 1) SizedBox(height: values.BASE_PADDING),
                if (_currentPage == 1)
                  CustomInput(
                    hint: "Vehicle Color",
                    controller: _engineNo,
                    validator: (value) {
                      if ((value as String).isEmpty)
                        return 'Please enter vehicle color';
                    },
                  ),
                SizedBox(height: values.BASE_PADDING * 1.5),
                CustomButton(
                  title: _buttonTitle[_currentPage],
                  onTab: () {
                    // _register
                    if (_currentPage < 2) {
                      _currentPage = _currentPage + 1;
                      setState(() {});
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainPage(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _register() async {
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   if (_firstName.text.isEmpty) {
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'ERROR!',
  //       message: 'Please enter first name',
  //     );
  //     return;
  //   }
  //   if (_lastName.text.isEmpty) {
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'ERROR!',
  //       message: 'Please enter last name',
  //     );
  //     return;
  //   }
  //   // if (!isPhoneValid(_phone.text)) {
  //   //   showBottomDialog(
  //   //     context: context,
  //   //     dialogType: enums.DialogType.ERROR,
  //   //     title: 'ERROR!',
  //   //     message: 'Please enter valid mobile number',
  //   //   );
  //   //   return;
  //   // }
  //   if (_phone.text.isEmpty) {
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'ERROR!',
  //       message: 'Please enter mobile number',
  //     );
  //     return;
  //   }
  //   if (!isEmail(_email.text)) {
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'ERROR!',
  //       message: 'Please enter valid email',
  //     );
  //     return;
  //   }
  //   if (_password.text.isEmpty) {
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'ERROR!',
  //       message: 'Please enter password',
  //     );
  //     return;
  //   }
  //   if (_password.text != _password.text) {
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'ERROR!',
  //       message: 'Password do not match',
  //     );
  //     return;
  //   }

  //   var progressDialog = getProgressDialog(context: context);
  //   progressDialog.show(useSafeArea: false);

  //   var result = await context.read<AuthenticationProvider>().register(
  //         firstName: _firstName.text,
  //         lastName: _lastName.text,
  //         email: _email.text,
  //         phone: _phone.text.replaceAll(' ', ''),
  //         password: _password.text,
  //       );

  //   if (result is ConsumerModel) {
  //     if (result.id != null && result.token != null) {
  //       progressDialog.dismiss();
  //       // Navigator.pushReplacement(
  //       //   context,
  //       //   MaterialPageRoute(
  //       //     builder: (_) => OTPVerification(
  //       //       id: result.id!,
  //       //       phone: _phone.text,
  //       //     ),
  //       //   ),
  //       // );
  //     } else {
  //       progressDialog.dismiss();
  //       showBottomDialog(
  //         context: context,
  //         dialogType: enums.DialogType.ERROR,
  //         title: 'Register Error',
  //         message: 'Oops! Something went wrong. Please try again.',
  //       );
  //     }
  //   } else if (result is String) {
  //     progressDialog.dismiss();
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'Register Error',
  //       message: result,
  //     );
  //   } else {
  //     progressDialog.dismiss();
  //     showBottomDialog(
  //       context: context,
  //       dialogType: enums.DialogType.ERROR,
  //       title: 'Register Error',
  //       message: 'Oops! Something went wrong. Please try again.',
  //     );
  //   }
  // }
}
