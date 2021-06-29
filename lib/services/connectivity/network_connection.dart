import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkConnection extends ChangeNotifier {
  bool _hasNetworkConnection = false;

  NetworkConnection() {
    _checkConnection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _checkConnection() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _hasNetworkConnection = false;
        notifyListeners();
        log(result.toString(), name: 'Internet Off');
      } else {
        _hasNetworkConnection = true;
        notifyListeners();
        log(result.toString(), name: 'Internet On');
      }
    });
  }

  // Getters
  bool get hasInternet => _hasNetworkConnection;
}
