import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../constants/api_constants.dart';
import '../controllers/dio_controller.dart';
import '../models/login_response_model.dart';
import 'preference_service.dart';

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

  Future<bool> updateProfile({
    required DioController dio,
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'staff/profile/update',
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        },
      );
      log(prettyJson(response.data), name: 'Update Profile Response');
      if (response.statusCode == 200) {
        return response.data['status'] as bool;
      } else {
        return false;
      }
    } on Exception catch (e, s) {
      log('Update Profile Error!', stackTrace: s, error: e);
      return false;
    }
  }

  Future<String> updateImage({
    required DioController dio,
    required String path,
  }) async {
    try {
      Dio _dio = Dio();
      String token = await PreferenceService.service.token;
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
        'accept': '*/*',
        'Content-Type': 'multipart/form-data',
      });
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(path),
      });
      Response response = await _dio.post(
        '${APIConstants.baseUrl}staff/profile/image/update',
        data: formData,
      );
      log(prettyJson(response.data), name: 'Update Image');
      if (response.statusCode == 200) {
        return response.data['image'] ?? '';
      } else {
        return '';
      }
    } on Exception catch (e, s) {
      log('Update Image Error!', stackTrace: s, error: e);
      return '';
    }
  }

  registerDeviceToken({
    required DioController dio,
    required String token,
  }) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String name = '';
      String type = '';
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        type = 'Android';
        name = androidInfo.model ?? '';
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        type = 'iOS';
        name = iosInfo.model ?? '';
      }

      Response response = await dio.dioClient.post(
        'staff/device/register',
        data: {
          "device_type": type,
          "device_token": token,
          "device_name": name,
        },
      );
      log(prettyJson(response.data), name: 'Token Register');
      if (response.statusCode == 200) {
        return response.data['status'] as bool;
      } else {
        return false;
      }
    } on Exception catch (e, s) {
      log('Token Register Error!', stackTrace: s, error: e);
      return false;
    }
  }
}
