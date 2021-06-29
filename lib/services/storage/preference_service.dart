import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/preferences.dart' as preferences;
import '../../models/consumer_mode.dart';

class PreferenceService {
  late SharedPreferences _sharedPreferences;

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // Setters
  setIsLogin(bool isLogin) => _sharedPreferences.setBool(
        preferences.IS_LOGIN,
        isLogin,
      );

  setUser(ConsumerModel consumer) => _sharedPreferences.setString(
        preferences.CONSUMER,
        jsonEncode(consumer.toJson()),
      );

  setToken(String token) => _sharedPreferences.setString(
        preferences.TOKEN,
        token,
      );

  clearPreferences() => _sharedPreferences.clear();

  // Getters
  bool get isLogin => _sharedPreferences.getBool(preferences.IS_LOGIN) ?? false;

  ConsumerModel get consumer => ConsumerModel.fromJson(
        jsonDecode(
          _sharedPreferences.getString(preferences.CONSUMER) ?? '{}',
        ),
      );

  String get token => _sharedPreferences.getString(preferences.TOKEN) ?? '';
}
