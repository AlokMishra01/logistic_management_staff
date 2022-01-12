import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logistic_management_staff/splash.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'constants/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final auth = context.watch<AuthenticationController>();
    // final _router = GoRouter(
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       builder: (context, state) => const Splash(),
    //     ),
    //     GoRoute(
    //       path: '/login',
    //       builder: (context, state) => const Login(),
    //     ),
    //   ],
    //   redirect: (state) {
    //     final loggedIn = auth.isLoggedIn;
    //     final loggingIn = state.subloc == '/login';
    //     if (!loggedIn) return loggingIn ? null : '/login';
    //
    //     if (loggingIn) return '/';
    //
    //     return null;
    //   },
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Logistic Management Staff',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: BUTTON_BLUE),
        textTheme: GoogleFonts.comfortaaTextTheme(),
      ),
      home: const Splash(),
      // routeInformationParser: _router.routeInformationParser,
      // routerDelegate: _router.routerDelegate,
    );
  }
}
