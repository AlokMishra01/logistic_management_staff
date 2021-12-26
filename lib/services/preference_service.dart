import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/preferences.dart' as preferences;
import '../models/login_response_model.dart';
import '../models/user_model.dart';

class PreferenceService {
  static PreferenceService service = PreferenceService();

  SharedPreferences? _sharedPreferences;

  _initSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  setUser(LoginResponseModel model) async {
    await _initSharedPreferences();
    _sharedPreferences?.setString(
      preferences.TOKEN,
      model.token ?? '',
    );
    _sharedPreferences?.setString(
      preferences.STAFF,
      jsonEncode(model.user?.toJson()),
    );
    _sharedPreferences?.setBool(
      preferences.IS_LOGIN,
      true,
    );
  }

  clearPreferences() async {
    await _initSharedPreferences();
    _sharedPreferences?.clear();
  }

  Future<bool> get isLogin async {
    await _initSharedPreferences();
    return _sharedPreferences?.getBool(preferences.IS_LOGIN) ?? false;
  }

  Future<UserModel> get staff async {
    await _initSharedPreferences();
    return UserModel.fromJson(
      jsonDecode(
        _sharedPreferences?.getString(preferences.STAFF) ?? '{}',
      ),
    );
  }

  Future<String> get token async {
    await _initSharedPreferences();
    return _sharedPreferences?.getString(preferences.TOKEN) ?? '';
  }
}
