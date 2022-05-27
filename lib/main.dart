import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/controllers/route_controller.dart';
import 'package:provider/provider.dart';

// import 'package:socket_io_client/socket_io_client.dart';

import 'app.dart';
import 'controllers/authentication_controller.dart';
import 'controllers/connectivity_controller.dart';
import 'controllers/delivery_controller.dart';
import 'controllers/dio_controller.dart';
import 'controllers/geo_locator_controller.dart';
import 'controllers/notification_controller.dart';
import 'controllers/pickup_controller.dart';
import 'controllers/printer_controller.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // try {
  //   AppUpdateInfo info = await InAppUpdate.checkForUpdate();
  //   if (info.updateAvailability == UpdateAvailability.updateAvailable) {
  //     await InAppUpdate.performImmediateUpdate();
  //   }
  // } catch (e, s) {
  //   log('In App Update Error!', error: e, stackTrace: s);
  // }

  // Socket socket = io(
  //     'https://trackingapi.logistics.intopros.com.np',
  //     OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .disableAutoConnect() // disable auto-connection
  //         .setExtraHeaders({'foo': 'bar'}) // optional
  //         .build());
  // socket.connect();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (cxt) => ConnectivityController(),
        ),
        ChangeNotifierProvider(
          create: (cxt) => PrinterController(),
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
            AuthenticationController, DeliveryController>(
          create: (cxt) => DeliveryController(null, null, null),
          update: (cxt, conn, dio, auth, pickup) => DeliveryController(
            conn,
            dio,
            auth,
          ),
        ),
        ChangeNotifierProxyProvider3<ConnectivityController, DioController,
            DeliveryController, PickupController>(
          create: (cxt) => PickupController(null, null, null),
          update: (cxt, conn, dio, delivery, pickup) => PickupController(
            conn,
            dio,
            delivery,
          ),
        ),
        ChangeNotifierProxyProvider3<ConnectivityController, DioController,
            AuthenticationController, RouteController>(
          create: (cxt) => RouteController(null, null, null),
          update: (cxt, conn, dio, auth, route) => RouteController(
            conn,
            dio,
            auth,
          ),
        ),
        ChangeNotifierProxyProvider<DioController, NotificationController>(
          create: (cxt) => NotificationController(null),
          update: (cxt, dio, n) => NotificationController(
            dio,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
