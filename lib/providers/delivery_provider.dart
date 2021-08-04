import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/models/dispatch_model.dart';

import '../constants/apis.dart' as apis;
import '../models/package_model.dart';
import '../services/api_service/client.dart';
import '../services/connectivity/network_connection.dart';

class DeliveryProvider extends ChangeNotifier {
  NetworkConnection _network = NetworkConnection();
  Dio _dio = Dio();
  bool _initilizing = true;
  // bool _loadingMore = false;
  // bool _canLoadMore = true;
  String _error = '';
  // int _page = 1;
  List<PackageModel> _packages = <PackageModel>[];
  List<DispatchModel> _dispatches = <DispatchModel>[];

  DeliveryProvider(this._network) {
    _dio = Client().init();
    fetchPackage(
      init: true,
      // reload: true,
    );
  }

  fetchPackage({
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
        Response r = await _dio.get('${apis.PACKAGE}');

        if (r.statusCode! >= 200 && r.statusCode! < 300) {
          if (r.data['response'] is Map) {
            List<PackageModel> p = List<PackageModel>.from(
              r.data['response']['packages'].map(
                (m) => PackageModel.fromJson(m),
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
          log(e.message, name: 'DeliveryProvider.fetchPackage');
        } else {
          _error = 'Oops! Some thing went wrong. Please try again.';
          log(e.toString(), name: 'DeliveryProvider.fetchPackage');
        }
      }
    } else {
      _error = 'No internet connection. Please connect to internet.';
    }
    _initilizing = false;
    notifyListeners();
  }

  fetchDispatched({
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
        Response r = await _dio.get('${apis.DISPATCHED_LIST}/$userId');

        if (r.statusCode! >= 200 && r.statusCode! < 300) {
          if (r.data['response'] is Map) {
            List<DispatchModel> d = List<DispatchModel>.from(
              r.data['response']['list']['data'].map(
                (m) => DispatchModel.fromJson(m),
              ),
            );
            _dispatches.clear();
            _dispatches.addAll(d);
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
          log(e.message, name: 'DeliveryProvider.fetchDispatched');
        } else {
          _error = 'Oops! Some thing went wrong. Please try again.';
          log(e.toString(), name: 'DeliveryProvider.fetchDispatched');
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
  List<PackageModel> get packages => _packages;
  List<DispatchModel> get dispatches => _dispatches;
}
