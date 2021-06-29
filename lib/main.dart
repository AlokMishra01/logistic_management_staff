import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'providers/authentication.dart';
import 'services/connectivity/network_connection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<NetworkConnection>(
          create: (_) => NetworkConnection(),
        ),
        ListenableProxyProvider<NetworkConnection, AuthenticationProvider>(
          update: (_, n, __) => AuthenticationProvider(n),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Logistic Management Staff',
        theme: ThemeData(
          primarySwatch: generateMaterialColor(color: BUTTON_BLUE),
          textTheme: GoogleFonts.comfortaaTextTheme(),
        ),
        home: Splash(),
      ),
    );
  }
}
