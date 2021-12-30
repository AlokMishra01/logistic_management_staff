import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/authentication_controller.dart';
import 'constants/colors.dart' as colors;
import 'controllers/connectivity_controller.dart';
import 'controllers/delivery_controller.dart';
import 'controllers/dio_controller.dart';
import 'controllers/geo_locator_controller.dart';
import 'controllers/pickup_controller.dart';
import 'services/preference_service.dart';
import 'views/login.dart';
import 'views/main_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectivityController>();
    context.read<DioController>();
    context.read<AuthenticationController>();
    context.read<GeoLocatorController>();
    context.read<PickupController>();
    context.read<DeliveryController>();
    _checkLogin();
  }

  _checkLogin() {
    Timer(const Duration(seconds: 2), () async {
      if (await PreferenceService.service.isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (cxt) => MainPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (cxt) => Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.TEXT_WHITE,
    );
  }
}
