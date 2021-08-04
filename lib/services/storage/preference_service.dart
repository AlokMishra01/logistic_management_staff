import 'dart:convert';

import 'package:logistic_management_staff/models/staff_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/preferences.dart' as preferences;

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

  setUser(StaffModel staff) => _sharedPreferences.setString(
        preferences.STAFF,
        jsonEncode(staff.toJson()),
      );

  clearPreferences() => _sharedPreferences.clear();

  // Getters
  bool get isLogin => _sharedPreferences.getBool(preferences.IS_LOGIN) ?? false;

  StaffModel get staff => StaffModel.fromJson(
        jsonDecode(
          _sharedPreferences.getString(preferences.STAFF) ?? '{}',
        ),
      );

  // String get token => _sharedPreferences.getString(preferences.TOKEN) ?? '';
}
