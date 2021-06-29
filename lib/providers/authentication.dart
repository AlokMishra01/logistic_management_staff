import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';

import '../../models/consumer_mode.dart';
import '../../services/connectivity/network_connection.dart';
import '../constants/apis.dart' as apis;
import '../services/api_service/client.dart';
import '../services/storage/preference_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  NetworkConnection _network;
  PreferenceService _preferenceService = PreferenceService();
  Dio _dio = Dio();
  bool _isLoggedIn = false;
  ConsumerModel? _consumer;

  AuthenticationProvider(this._network) {
    _init();
  }

  _init() async {
    _dio = Client().init();
    await _preferenceService.init();
    _isLoggedIn = _preferenceService.isLogin;
    log('$_isLoggedIn', name: 'Logged');
    if (_isLoggedIn) {
      _consumer = _preferenceService.consumer;
      getConsumerInfo(id: _consumer!.id ?? 0);
    }
  }

  dynamic login({required String phone, required String password}) async {
    if (_network.hasInternet) {
      try {
        Response response = await _dio.post(apis.LOGIN, data: {
          'mobile': phone,
          'password': password,
        });
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          if (response.data['response'] is Map) {
            var c = ConsumerModel.fromJson(response.data['response']);
            _preferenceService.setUser(c);
            _preferenceService.setIsLogin(true);
            _preferenceService.setToken(c.token!);
            _consumer = c;
            _isLoggedIn = true;
            notifyListeners();
            return _consumer;
          } else
            return response.data['message'];
        } else {
          return response.statusMessage;
        }
      } catch (error) {
        if (error is DioError) {
          log(
            error.message,
            name: 'Login Error',
          );
          return error.message;
        } else {
          log(
            error.toString(),
            name: 'Login Error',
          );
          return error.toString();
        }
      }
    } else {
      return 'No internet connection. Please connect to internet.';
    }
  }

  dynamic logOut() {
    _preferenceService.clearPreferences();
    _isLoggedIn = _preferenceService.isLogin;
    if (!_isLoggedIn)
      _consumer = null;
    else
      _consumer = _preferenceService.consumer;
    notifyListeners();
  }

  dynamic getConsumerInfo({required int id}) async {
    if (_network.hasInternet) {
      try {
        Response response = await _dio.post(apis.CONSUMER_INFO, data: {
          'id': id,
        });
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          if (response.data['response'] is Map) {
            var c = ConsumerModel.fromJson(response.data['response']);
            c.token = _preferenceService.token;
            _preferenceService.setUser(c);
            _consumer = c;
            notifyListeners();
            return _consumer;
          } else
            return response.data['message'];
        } else {
          return response.statusMessage;
        }
      } catch (error) {
        if (error is DioError) {
          log(
            error.message,
            name: 'Consumer Info Error',
          );
          return error.message;
        } else {
          log(
            error.toString(),
            name: 'Consumer Info Error',
          );
          return error.toString();
        }
      }
    } else {
      return 'No internet connection. Please connect to internet.';
    }
  }

  dynamic changePassword({required int id, required String password}) {
    if (_network.hasInternet) {
      _dio.post(apis.CHANGE_PASSWORD, data: {
        'id': id,
        'password': password,
      }).then((value) {
        log(
          jsonEncode(prettyJson(value.data)),
          name: 'Change Password Response Data',
        );
      }).onError((error, stackTrace) {
        log(
          error.toString(),
          name: 'Change Password Error',
          stackTrace: stackTrace,
        );
      });
    } else {
      return 'No internet connection. Please connect to internet.';
    }
  }

  dynamic register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (_network.hasInternet) {
      try {
        Response response = await _dio.post(apis.REGISTER, data: {
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'mobile': phone,
          'password': password,
        });
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          if (response.data['response'] is Map) {
            var c = ConsumerModel.fromJson(response.data['response']);
            _preferenceService.setToken(c.token!);
            _preferenceService.setUser(c);
            _preferenceService.setIsLogin(false);
            _consumer = c;
            _isLoggedIn = false;
            notifyListeners();
            return _consumer;
          } else
            return response.data['message'];
        } else {
          return response.statusMessage;
        }
      } catch (error) {
        if (error is DioError) {
          log(
            error.message,
            name: 'Register Error',
          );
          return error.message;
        } else {
          log(
            error.toString(),
            name: 'Register Error',
          );
          return error.toString();
        }
      }
    } else {
      return 'No internet connection. Please connect to internet.';
    }
  }

  dynamic verifyOTP({required id, required String otp}) async {
    if (_network.hasInternet) {
      try {
        Response response = await _dio.post(apis.VERIFY_OTP, data: {
          'id': id,
          'otp_code': otp,
        });
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          if (response.data['response'] is Map) {
            var c = ConsumerModel.fromJson(response.data['response']);
            var info = await getConsumerInfo(id: c.id!);
            if (info is ConsumerModel) {
              _preferenceService.setIsLogin(true);
              _isLoggedIn = true;
              notifyListeners();
              return info;
            } else if (info is String) {
              return info;
            } else {
              return 'Oops! Some thing went wrong. Please try again.';
            }
          } else
            return response.data['message'];
        } else {
          return response.statusMessage;
        }
      } catch (error) {
        if (error is DioError) {
          log(
            error.message,
            name: 'Verify OTP Error',
          );
          return error.message;
        } else {
          log(
            error.toString(),
            name: 'Verify OTP Error',
          );
          return error.toString();
        }
      }
    } else {
      return 'No internet connection. Please connect to internet.';
    }
  }

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  ConsumerModel? get consumer => _consumer;
}
