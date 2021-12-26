import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logistic_management_staff/splash.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'controllers/authentication_controller.dart';
import 'controllers/connectivity_controller.dart';
import 'controllers/delivery_controller.dart';
import 'controllers/dio_controller.dart';
import 'controllers/geo_locator_controller.dart';
import 'controllers/pickup_controller.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (cxt) => ConnectivityController(),
        ),
        ChangeNotifierProvider(
          create: (cxt) => DioController(cxt),
        ),
        ChangeNotifierProxyProvider2<ConnectivityController, DioController,
            AuthenticationController>(
          create: (cxt) => AuthenticationController(null, null),
          update: (cxt, conn, dio, auth) => AuthenticationController(conn, dio),
        ),
        ChangeNotifierProxyProvider2<ConnectivityController,
            AuthenticationController, GeoLocatorController>(
          create: (cxt) => GeoLocatorController(null, null),
          update: (cxt, conn, auth, geo) => GeoLocatorController(
            conn,
            auth,
          ),
        ),
        ChangeNotifierProxyProvider3<ConnectivityController, DioController,
            AuthenticationController, PickupController>(
          create: (cxt) => PickupController(null, null, null),
          update: (cxt, conn, dio, auth, pickup) => PickupController(
            conn,
            dio,
            auth,
          ),
        ),
        ChangeNotifierProxyProvider3<ConnectivityController, DioController,
            AuthenticationController, DeliveryController>(
          create: (cxt) => DeliveryController(null, null, null),
          update: (cxt, conn, dio, auth, pickup) => DeliveryController(
            conn,
            dio,
            auth,
          ),
        ),
      ],

      // Todo: use go router
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Logistic Management Staff',
        theme: ThemeData(
          primarySwatch: generateMaterialColor(color: BUTTON_BLUE),
          textTheme: GoogleFonts.comfortaaTextTheme(),
        ),
        // home: Splash(),
        home: Splash(),
      ),
    );
  }
}
