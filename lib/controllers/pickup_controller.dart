import 'package:flutter/material.dart';

import '../models/pickup_response_model.dart';
import '../services/pickup_service.dart';
import 'connectivity_controller.dart';
import 'delivery_controller.dart';
import 'dio_controller.dart';

class PickupController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final DioController? _dioController;
  final DeliveryController? _deliveryController;

  final _pickupService = PickupService.service;

  PickupController(
    this._connectivityController,
    this._dioController,
    this._deliveryController,
  ) {
    getPendingPickups();
    getPickedUpPickups();
  }

  getPendingPickups({bool init = true}) async {
    if (_dioController == null) {
      return;
    }

    if (init) {
      _pagePendingAt = 1;
      _canPendingLoadMore = true;
    } else {
      if (!_canPendingLoadMore) {
        return;
      } else {
        _pagePendingAt++;
      }
    }

    final result = await _pickupService.getPickups(
      dio: _dioController!,
      page: _pagePendingAt,
    );

    if (result is PickupResponseData) {
      if (init) {
        _pendingPickups
          ..clear()
          ..addAll(result.data ?? []);
      } else {
        _pendingPickups.addAll(result.data ?? []);
      }
      if ((result.lastPage ?? 0) <= _pagePendingAt) {
        _canPendingLoadMore = false;
      }
      notifyListeners();
    }
  }

  getPickedUpPickups({bool init = true}) async {
    if (_dioController == null) {
      return;
    }

    if (init) {
      _pagePickedUpAt = 1;
      _canPickedUpLoadMore = true;
    } else {
      if (!_canPickedUpLoadMore) {
        return;
      } else {
        _pagePickedUpAt++;
      }
    }

    final result = await _pickupService.getPickups(
      dio: _dioController!,
      status: 'Picked Up',
      page: _pagePickedUpAt,
    );

    if (result is PickupResponseData) {
      if (init) {
        _pickedUpPickups
          ..clear()
          ..addAll(result.data ?? []);
      } else {
        _pickedUpPickups.addAll(result.data ?? []);
      }
      if ((result.lastPage ?? 0) <= _pagePickedUpAt) {
        _canPickedUpLoadMore = false;
      }
      notifyListeners();
    }
  }

  Future<String> pickupPackage({required int packageID}) async {
    if (_dioController == null) {
      return '';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return '';
    }

    String result = await _pickupService.postPackagePickup(
      dio: _dioController!,
      packageId: packageID,
    );

    if (result.isNotEmpty) {
      _deliveryController?.getDispatched();
      getPendingPickups();
      getPickedUpPickups();
    }

    return result;
  }

  // Pending
  int _pagePendingAt = 1;
  bool _canPendingLoadMore = true;
  List<PickupDataModel> _pendingPickups = [];
  List<PickupDataModel> get pendingPickups => _pendingPickups;

  // Picked Up
  int _pagePickedUpAt = 1;
  bool _canPickedUpLoadMore = true;
  List<PickupDataModel> _pickedUpPickups = [];
  List<PickupDataModel> get pickedUpPickups => _pickedUpPickups;
}
