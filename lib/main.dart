import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   AppUpdateInfo info = await InAppUpdate.checkForUpdate();
  //   if (info.updateAvailability == UpdateAvailability.updateAvailable) {
  //     await InAppUpdate.performImmediateUpdate();
  //   }
  // } catch (e, s) {
  //   log('In App Update Error!', error: e, stackTrace: s);
  // }
  runApp(MyApp());
}
