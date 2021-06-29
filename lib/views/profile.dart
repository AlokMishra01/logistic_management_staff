import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/constants/colors.dart';
import 'package:logistic_management_staff/constants/values.dart';
import 'package:logistic_management_staff/widgets/custom_button.dart';
import 'package:logistic_management_staff/widgets/custom_input.dart';
import 'package:logistic_management_staff/widgets/detail_row.dart';
import 'package:logistic_management_staff/widgets/header.dart';
import 'package:logistic_management_staff/widgets/profile_info_heading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<TextEditingController> _assignedRoutes = [];
  List<TextEditingController> _assignedVechiles = [];

  @override
  void initState() {
    _assignedRoutes.add(TextEditingController(text: '1. Bhaktapur'));
    _assignedRoutes.add(TextEditingController(text: '2. Kathamandu'));
    _assignedVechiles.add(TextEditingController(text: '1. Jeep'));
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController c in _assignedRoutes) c.dispose();
    for (TextEditingController c in _assignedVechiles) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: BASE_PADDING),
        Header(
          title: 'Profile',
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
            child: CircleAvatar(
              backgroundColor: FIELD_BACKGROUND,
              child: IconButton(
                icon: Icon(CupertinoIcons.pen),
                color: BUTTON_BLUE,
                onPressed: () {},
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "images/user.png",
                    ),
                    radius: size.width * 0.2,
                    backgroundColor: TEXT_BLUE.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: BASE_PADDING / 2),
                Padding(
                  padding: const EdgeInsets.all(BASE_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfoHeading(title: 'Basic Information'),
                      DetailRow(title: 'Name: ', value: 'Rajendra Prajapati'),
                      DetailRow(title: 'Address: ', value: 'Bhaktapur'),
                      DetailRow(title: 'Mobile Number: ', value: '9878787654'),
                      DetailRow(title: 'Email', value: 'Rajendra@gmail.com'),
                      SizedBox(height: BASE_PADDING * 2),
                      ProfileInfoHeading(title: 'Assigned Routes'),
                      for (TextEditingController c in _assignedRoutes)
                        Padding(
                          padding: const EdgeInsets.only(top: BASE_PADDING / 2),
                          child: CustomInput(
                            controller: c,
                            hint: c.text,
                            enabled: false,
                            icon: CupertinoIcons.eye,
                          ),
                        ),
                      SizedBox(height: BASE_PADDING * 2),
                      ProfileInfoHeading(title: 'Assigned Vehicle'),
                      for (TextEditingController c in _assignedVechiles)
                        Padding(
                          padding: const EdgeInsets.only(top: BASE_PADDING / 2),
                          child: CustomInput(
                            controller: c,
                            hint: c.text,
                            enabled: false,
                            icon: CupertinoIcons.eye,
                          ),
                        ),
                      SizedBox(height: BASE_PADDING * 2),
                      ProfileInfoHeading(title: 'History'),
                      SizedBox(height: BASE_PADDING / 2),
                      CustomButton(
                        title: 'View History',
                        onTab: () {},
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
