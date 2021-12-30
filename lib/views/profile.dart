import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../controllers/authentication_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/detail_row.dart';
import '../widgets/header.dart';
import '../widgets/profile_info_heading.dart';
import 'history.dart';
import 'login.dart';

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
    final auth = context.watch<AuthenticationController>();
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
                    backgroundImage: NetworkImage(
                      "${auth.userModel?.photo}",
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
                      DetailRow(
                        title: 'Name: ',
                        value: '${auth.userModel?.name}',
                      ),
                      DetailRow(
                        title: 'Address: ',
                        // value: '${auth.userModel?.address}',
                        value: 'N/a',
                      ),
                      DetailRow(
                        title: 'Mobile Number: ',
                        value: '${auth.userModel?.phone}',
                      ),
                      DetailRow(
                        title: 'Email',
                        value: '${auth.userModel?.email}',
                      ),
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
                        onTab: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (cxt) => HistoryView(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: BASE_PADDING / 2),
                      CustomButton(
                        title: 'Logout',
                        onTab: () {
                          auth.logOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Login(),
                            ),
                            (route) => false,
                          );
                        },
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
