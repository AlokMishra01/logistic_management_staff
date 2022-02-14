import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logistic_management_staff/models/pickup_response_model.dart';
import 'package:pretty_json/pretty_json.dart';

import '../constants/api_constants.dart';
import '../controllers/dio_controller.dart';

class PickupService {
  static PickupService service = PickupService();

  Future<PickupResponseData?> getPickups({
    required DioController dio,
    String status = 'Pending', // Pending, Picked Up
    int page = 1,
    int limit = 20,
  }) async {
    try {
      Response response = await dio.dioClient.get(
        '${APIConstants.pickupList}?status=$status&page=$page&limit=$limit',
      );

      if (response.statusCode == 200) {
        final data = PickupResponseModel.fromJson(response.data);
        return data.data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Pickups Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<String> postPackagePickup({
    required DioController dio,
    required int packageId,
  }) async {
    try {
      // var formData = FormData.fromMap({
      //   'package_id': packageId,
      // });
      Response response = await dio.dioClient.post(
        APIConstants.postPackagePickup,
        data: {
          'package_id': packageId,
        },
      );
      log('Post Package Pickup Data!: ${prettyJson(response.data)}');
      if (response.statusCode == 200) {
        bool b = (response.data['status'] ?? false) as bool;
        if (b) {
          return (response.data['barcode'] ?? '') as String;
        }
        return '';
      } else {
        return '';
      }
    } on Exception catch (e, s) {
      log('Post Package Pickup Error!', stackTrace: s, error: e);
      return '';
    }
  }
}
