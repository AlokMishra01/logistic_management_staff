import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistic_management_staff/models/get_vehicle_response_model.dart';
import 'package:logistic_management_staff/models/route_response_model.dart';
import 'package:logistic_management_staff/services/route_service.dart';

import 'authentication_controller.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class RouteController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final DioController? _dioController;
  final AuthenticationController? _authenticationController;

  final _routeService = RouteService.service;

  RouteController(
    this._connectivityController,
    this._dioController,
    this._authenticationController,
  ) {
    getVechile();
    getRoute();
  }

  getVechile() async {
    if (_dioController == null) {
      return;
    }

    if (_loadingVehicle) {
      return;
    }

    _loadingVehicle = true;
    notifyListeners();

    final result = await _routeService.getVehicle(dio: _dioController!);

    if (result?.data?.route?.routePoints != null) {
      List points = jsonDecode(result?.data?.route?.routePoints ?? '[]');
      for (Map<String, dynamic> p in points) {
        _markers.add(
          Marker(
            markerId: MarkerId('${p['lat']},${p['lng']}'),
            position: LatLng(p['lat'], p['lng']),
          ),
        );
      }
    }

    _vehicle = result;
    _loadingVehicle = false;
    notifyListeners();
  }

  getRoute() async {
    if (_dioController == null) {
      return;
    }

    final result = await _routeService.getRoute(dio: _dioController!);

    _route = result;
    notifyListeners();
  }

  // route
  RouteResponseModel? _route;
  RouteResponseModel? get route => _route;

  // Dispatc Pickup
  GetVehicleResponseModel? _vehicle;
  GetVehicleResponseModel? get vehicle => _vehicle;
  bool _loadingVehicle = false;
  bool get loadingVehicle => _loadingVehicle;

  // points
  Set<Marker> _markers = <Marker>{};
  Set<Marker> get markers => _markers;
}
