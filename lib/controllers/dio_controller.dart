import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/controllers/authentication_controller.dart';
import 'package:logistic_management_staff/services/preference_service.dart';
import 'package:logistic_management_staff/views/login.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:provider/provider.dart';

import '../constants/api_constants.dart';

class DioController with ChangeNotifier {
  final BuildContext _context;
  final Dio _dio = Dio();

  DioController(this._context) {
    _dio.options.baseUrl = APIConstants.baseUrl;
    // _dio.options.headers.addAll({
    //   'Accept': '*/*',
    // });
    _dio.options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log(prettyJson(options.uri.toString()), name: 'API Request Url');
    log(prettyJson(options.headers), name: 'API Request Headers');
    // log(prettyJson(options.data), name: 'API Request Data');
    String token = await PreferenceService.service.token;
    if (token.isNotEmpty) {
      options.headers.addAll(
        {'Authorization': 'Bearer $token'},
      );
    }
    return handler.next(options);
  }

  _onResponse(Response response, ResponseInterceptorHandler handler) async {
    log(prettyJson(response.data), name: 'API Response Data');
    if (response.data['status_code'] == 401) {
      log('Logging Out User', name: 'API 401 Error!');
      _context.read<AuthenticationController>().logOut();
      Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
          builder: (_) => Login(),
        ),
        (route) => false,
      );
    }
    return handler.next(response);
  }

  _onError(DioError error, ErrorInterceptorHandler handler) async {
    log(prettyJson(error.type.toString()), name: 'API Error');
    log(prettyJson(error.response?.data ?? ''), name: 'API Error Response');
    if (error.response!.statusCode == 401) {
      _context.read<AuthenticationController>().logOut();
      Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
          builder: (_) => Login(),
        ),
        (route) => false,
      );
    }
    return handler.next(error);
  }

  Dio get dioClient => _dio;
}
