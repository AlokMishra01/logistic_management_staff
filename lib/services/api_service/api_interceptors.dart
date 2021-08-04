import 'dart:developer';

import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(options, handler) async {
    // PreferenceService p = PreferenceService();
    // await p.init();
    // String token = p.token;
    // options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    log(response.data.toString(), name: 'Response');
    handler.next(response);
  }

  @override
  void onError(err, handler) {
    log(err.response!.data.toString(), name: 'ERROR');
    handler.next(err);
  }
}
