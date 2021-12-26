import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_json/pretty_json.dart';

class LocationService {
  static LocationService service = LocationService();

  /// Request
  /// method: POST
  /// url: https://trackingapi.logistics.intopros.com.np/rider-update-location
  /// header: Authorization: {secret-key-here-without-brackets}
  /// body:
  /// {
  ///   "staff_id": 200202002,
  ///   "latitude": "23.456789",
  ///   "longitude": "12.34567",
  /// }

  Future<bool> uploadLocation({
    required int id,
    required LatLng latLng,
  }) async {
    try {
      Dio _dio = Dio();
      _dio.options.headers.addAll(
        {'Authorization': 'secret@1234567890'},
      );
      ;
      Response response = await _dio.post(
        'https://trackingapi.logistics.intopros.com.np/rider-update-location',
        data: {
          "staff_id": id,
          "latitude": latLng.latitude,
          "longitude": latLng.longitude,
        },
      );
      log(prettyJson(response.data), name: 'Upload Location Response');
      return true;
    } on Exception catch (e, s) {
      log('Upload Location Error!', stackTrace: s, error: e);
      return false;
    }
  }
}
