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
    if (_connectivityController != null && _dioController != null) {
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

  Future<bool> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    if (_isLoading) {
      return false;
    }

    if (_connectivityController == null) {
      return false;
    }

    if (_dioController == null) {
      return false;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return false;
    }

    if (_userModel == null) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    bool b = await _authenticationService.updateProfile(
      dio: _dioController!,
      name: name,
      email: email,
      phone: phone,
    );

    _isLoading = false;

    if (b) {
      _userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        id: _userModel?.id,
        experience: _userModel?.experience,
        license: _userModel?.license,
        licensePhoto: _userModel?.licensePhoto,
        photo: _userModel?.photo,
      );
      await _preferenceService.setUserProfile(_userModel!);
      notifyListeners();
    }

    return b;
  }

  Future<bool> updateImage({required String path}) async {
    if (_isLoading) {
      return false;
    }

    if (_connectivityController == null) {
      return false;
    }

    if (_dioController == null) {
      return false;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return false;
    }

    if (_userModel == null) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    String b = await _authenticationService.updateImage(
      dio: _dioController!,
      path: path,
    );

    _isLoading = false;

    if (b.isNotEmpty) {
      _userModel = UserModel(
        name: _userModel?.name,
        email: _userModel?.email,
        phone: _userModel?.phone,
        id: _userModel?.id,
        experience: _userModel?.experience,
        license: _userModel?.license,
        licensePhoto: _userModel?.licensePhoto,
        photo: b,
      );
      await _preferenceService.setUserProfile(_userModel!);
      notifyListeners();
    }

    return b.isNotEmpty;
  }

  Future<bool> registerDevice({required String token}) async {
    if (_connectivityController == null) {
      return false;
    }

    if (_dioController == null) {
      return false;
    }

    if (_userModel == null) {
      return false;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return false;
    }

    bool b = await _authenticationService.registerDeviceToken(
      dio: _dioController!,
      token: token,
    );

    return b;
  }

  /// Data
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
}
