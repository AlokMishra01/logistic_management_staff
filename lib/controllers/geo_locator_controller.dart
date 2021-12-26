import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/location_service.dart';
import 'authentication_controller.dart';
import 'connectivity_controller.dart';

class GeoLocatorController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final AuthenticationController? _authenticationController;

  late StreamSubscription<Position> _locationSubscription;
  LatLng? _location;
  bool _uploading = false;

  GeoLocatorController(
    this._connectivityController,
    this._authenticationController,
  ) {
    if (_connectivityController != null && _authenticationController != null) {
      _locationSubscription = Geolocator.getPositionStream(
        locationSettings: _locationSettings,
      ).listen(
        (position) {
          log('Position: ${position.latitude},${position.longitude}');
          _location = LatLng(position.latitude, position.longitude);
          if (_location != null) {
            _uploadLocation(latLng: _location!);
          }
        },
      );
    }
  }

  final LocationSettings _locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
    // timeLimit: Duration(seconds: 5),
  );

  _uploadLocation({required LatLng latLng}) async {
    if (_uploading) {
      return;
    }

    if (_location == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    if (!(_authenticationController?.isLoggedIn ?? false)) {
      return;
    }

    if (_authenticationController?.userModel?.id == null) {
      return;
    }

    _uploading = true;

    bool b = await LocationService.service.uploadLocation(
      id: _authenticationController?.userModel?.id ?? 0,
      latLng: latLng,
    );
    log('Uploading Staff Location: $b');

    _uploading = false;
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  LatLng? get location => _location;
}
