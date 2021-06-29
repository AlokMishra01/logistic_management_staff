import 'package:dio/dio.dart';

import '../../constants/apis.dart' as apis;
import 'api_interceptors.dart';

class Client {
  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(ApiInterceptors());
    _dio.options.baseUrl = apis.BASE_URL;
    _dio.options.responseType = ResponseType.json;
    return _dio;
  }
}
