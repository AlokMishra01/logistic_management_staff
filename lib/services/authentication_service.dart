import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../constants/api_constants.dart';
import '../controllers/dio_controller.dart';
import '../models/login_response_model.dart';

class AuthenticationService {
  static AuthenticationService service = AuthenticationService();

  /// 9841231230
  /// logistic@123
  Future<LoginResponseModel?> login({
    required DioController dio,
    required String phone,
    required String password,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        APIConstants.login,
        data: {
          "phone": phone,
          "password": password,
        },
      );
      log(prettyJson(response.data), name: 'Login Response');
      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Login Error!', stackTrace: s, error: e);
      return null;
    }
  }
}
