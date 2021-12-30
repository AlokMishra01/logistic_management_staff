import 'package:flutter/material.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';

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
  ) {
    getAssigned();
    getDelivered();
  }

  getDelivered({bool init = true}) async {
    if (_dioController == null) {
      return;
    }

    if (init) {
      _pageDeliveredAt = 1;
      _canDeliveredLoadMore = true;
    } else {
      if (!_canDeliveredLoadMore) {
        return;
      } else {
        _pageDeliveredAt++;
      }
    }

    final result = await _deliveryService.getDeliveries(
      dio: _dioController!,
      page: _pageDeliveredAt,
    );

    if (result is AssignedData) {
      if (init) {
        _deliveredList
          ..clear()
          ..addAll(result.assignedList ?? []);
      } else {
        _deliveredList.addAll(result.assignedList ?? []);
      }
      if ((result.lastPage ?? 0) <= _pageDeliveredAt) {
        _canDeliveredLoadMore = false;
      }
      notifyListeners();
    }
  }

  getAssigned({bool init = true}) async {
    if (_dioController == null) {
      return;
    }

    if (init) {
      _pageAssignedAt = 1;
      _canAssignedLoadMore = true;
    } else {
      if (!_canAssignedLoadMore) {
        return;
      } else {
        _pageAssignedAt++;
      }
    }

    final result = await _deliveryService.getAssignedList(
      dio: _dioController!,
      page: _pageAssignedAt,
    );

    if (result is AssignedData) {
      if (init) {
        _assignedList
          ..clear()
          ..addAll(result.assignedList ?? []);
      } else {
        _assignedList.addAll(result.assignedList ?? []);
      }
      if ((result.lastPage ?? 0) <= _pageAssignedAt) {
        _canAssignedLoadMore = false;
      }
      notifyListeners();
    }
  }

  Future<bool> deliverPackage({
    required int packageID,
    required int dispatchID,
    required String imagePath,
  }) async {
    if (_dioController == null) {
      return false;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return false;
    }

    bool b = await _deliveryService.postPackageDelivery(
      dio: _dioController!,
      packageId: packageID,
      dispatchId: dispatchID,
      imagePath: imagePath,
    );

    if (b) {
      getAssigned();
      getDelivered();
    }

    return b;
  }

  // Delivered
  int _pageDeliveredAt = 1;
  bool _canDeliveredLoadMore = true;
  List<AssignedModel> _deliveredList = [];
  List<AssignedModel> get deliveredList => _deliveredList;

  // Assigned
  int _pageAssignedAt = 1;
  bool _canAssignedLoadMore = true;
  List<AssignedModel> _assignedList = [];
  List<AssignedModel> get assignedList => _assignedList;
}
