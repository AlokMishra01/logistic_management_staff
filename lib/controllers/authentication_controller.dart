import 'package:flutter/material.dart';

import '../models/login_response_model.dart';
import '../models/user_model.dart';
import '../services/authentication_service.dart';
import '../services/preference_service.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class AuthenticationController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final DioController? _dioController;

  final _authenticationService = AuthenticationService.service;
  final _preferenceService = PreferenceService.service;

  AuthenticationController(this._connectivityController, this._dioController) {
    if (this._connectivityController != null && this._dioController != null) {
      _initLogin();
    }
  }

  _initLogin() async {
    _isLoggedIn = await _preferenceService.isLogin;
    _userModel = await _preferenceService.staff;
  }

  Future<String> login({
    required String phone,
    required String password,
  }) async {
    if (_dioController == null) {
      return 'Oops! Something went wrong.';
    }

    LoginResponseModel? model = await _authenticationService.login(
      dio: _dioController!,
      phone: phone,
      password: password,
    );

    if (model?.statusCode != 200) {
      return model?.message ?? 'Oops! Something went wrong.';
    }

    await _preferenceService.setUser(model!);
    _initLogin();

    return '';
  }

  logOut() async {
    await _preferenceService.clearPreferences();
    _initLogin();
  }

  /// Data
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;
}
