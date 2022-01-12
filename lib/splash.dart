import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/providerient.dart';

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
    context.read<PickupController>().getPickedUpPickups();
    context.read<PickupController>().getPendingPickups();
    context.read<DeliveryController>().getAssigned();
    context.read<DeliveryController>().getDelivered();
    _checkLogin();
  }

  _checkLogin() {
    Timer(const Duration(seconds: 3), () async {
      if (await PreferenceService.service.isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (cxt) => const MainPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (cxt) => const Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colors.TEXT_WHITE,
    );
  }
}
