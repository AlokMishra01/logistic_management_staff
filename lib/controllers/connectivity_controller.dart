import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityController with ChangeNotifier {
  late StreamSubscription _networkSubscription;
  bool _hasNetworkConnection = true;

  ConnectivityController() {
    _networkSubscription = Connectivity().onConnectivityChanged.listen(
      (result) {
        switch (result) {
          case ConnectivityResult.none:
            if (_hasNetworkConnection) {
              _hasNetworkConnection = false;
              notifyListeners();
            }
            break;
          default:
            if (!_hasNetworkConnection) {
              _hasNetworkConnection = true;
              notifyListeners();
            }
        }
      },
    );
  }

  @override
  void dispose() {
    _networkSubscription.cancel();
    super.dispose();
  }

  bool get hasInternet => _hasNetworkConnection;
}
