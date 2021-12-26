import 'package:flutter/material.dart';

import '../services/delivery_service.dart';
import 'authentication_controller.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class DeliveryController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final DioController? _dioController;
  final AuthenticationController? _authenticationController;

  final _deliveryService = DeliveryService.service;

  DeliveryController(
    this._connectivityController,
    this._dioController,
    this._authenticationController,
  );
}
