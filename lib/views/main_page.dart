import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/views/available_orders.dart';
import 'package:logistic_management_staff/views/load.dart';
import 'package:logistic_management_staff/views/profile.dart';
import 'package:logistic_management_staff/views/route.dart';
import 'package:logistic_management_staff/widgets/dialogs/custom_dialog.dart';

import '../constants/colors.dart' as colors;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CustomDialogs.dialogs.showCustomDialog(
          context: context,
          type: DialogType.appClose,
        );
        return false;
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     context.read<PickupController>().pickupPackage(packageID: 20);
        //   },
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _setCurrentIndex,
          selectedLabelStyle: const TextStyle(
            color: colors.TEXT_BLUE,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          selectedItemColor: colors.BUTTON_BLUE,
          unselectedItemColor: colors.TEXT_SECONDARY,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: 'Orders',
              icon: Icon(CupertinoIcons.checkmark_alt_circle),
            ),
            BottomNavigationBarItem(
              label: 'Load',
              icon: Icon(CupertinoIcons.cube_box),
            ),
            BottomNavigationBarItem(
              label: 'Route',
              icon: Icon(CupertinoIcons.map),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(CupertinoIcons.person),
            ),
          ],
        ),
        body: SafeArea(child: _getCurrentPage()),
      ),
    );
  }

  _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const AvailableOrders();
      case 1:
        return const Load();
      case 2:
        return const MapRoutes();
      case 3:
        return const Profile();
      default:
        return Container();
    }
  }

  _setCurrentIndex(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
