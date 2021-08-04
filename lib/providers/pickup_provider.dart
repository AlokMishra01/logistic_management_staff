import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants/apis.dart' as apis;
import '../models/request_model.dart';
import '../services/api_service/client.dart';
import '../services/connectivity/network_connection.dart';

class PickUpProvider extends ChangeNotifier {
  NetworkConnection _network = NetworkConnection();
  Dio _dio = Dio();
  bool _initilizing = true;
  // bool _loadingMore = false;
  // bool _canLoadMore = true;
  String _error = '';
  // int _page = 1;
  List<RequestModel> _packages = <RequestModel>[];

  PickUpProvider(this._network) {
    _dio = Client().init();
  }

  fetchPickUp({
    required int userId,
    bool init = false,
    // bool reload = false,
  }) async {
    _error = '';
    // if (reload) {
    //   _page = 1;
    //   _loadingMore = false;
    //   _canLoadMore = true;
    // } else {
    //   _loadingMore = true;
    // }
    if (init)
      _initilizing = true;
    else
      notifyListeners();

    if (_network.hasInternet) {
      try {
        Response r = await _dio.get('${apis.PICKUP}/$userId');

        if (r.statusCode! >= 200 && r.statusCode! < 300) {
          if (r.data['response'] is Map) {
            List<RequestModel> p = List<RequestModel>.from(
              r.data['response']['packages'].map(
                (m) => RequestModel.fromJson(m),
              ),
            );
            _packages.clear();
            _packages.addAll(p);
            // if (reload)
            //   _blogs = blogs;
            // else
            //   _blogs.addAll(blogs);
            //
            // if (r.data['next_page_url'] != null) {
            //   _page = _page + 1;
            // } else {
            //   _canLoadMore = false;
            // }
          } else {
            _error = r.data['message'] as String;
          }
        }
      } catch (e) {
        if (e is DioError) {
          _error = e.message;
          log(e.message, name: 'PickUpProvider.fetchPickUp');
        } else {
          _error = 'Oops! Some thing went wrong. Please try again.';
          log(e.toString(), name: 'PickUpProvider.fetchPickUp');
        }
      }
    } else {
      _error = 'No internet connection. Please connect to internet.';
    }
    _initilizing = false;
    notifyListeners();
  }

  // Getters
  bool get initilizing => _initilizing;
  // bool get loadingMore => _loadingMore;
  // bool get canLoadMore => _canLoadMore;
  String get error => _error;
  List<RequestModel> get requests => _packages;
}
