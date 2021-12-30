import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';

import '../constants/api_constants.dart';
import '../controllers/dio_controller.dart';

class DeliveryService {
  static DeliveryService service = DeliveryService();

  Future<AssignedData?> getDeliveries({
    required DioController dio,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      Response response = await dio.dioClient.get(
        '${APIConstants.deliveryList}?page=$page&limit=$limit',
      );

      if (response.statusCode == 200) {
        final data = AssignedResponseModel.fromJson(response.data);
        return data.data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Deliveries Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<AssignedData?> getAssignedList({
    required DioController dio,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      Response response = await dio.dioClient.get(
        '${APIConstants.assignedList}?page=$page&limit=$limit',
      );

      if (response.statusCode == 200) {
        final data = AssignedResponseModel.fromJson(response.data);
        return data.data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Deliveries Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<bool> postPackageDelivery({
    required DioController dio,
    required int packageId,
    required int dispatchId,
    required String imagePath,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'package_id': packageId,
        'dispatch_id': dispatchId,
        'file': await MultipartFile.fromFile(imagePath),
      });

      Response response = await dio.dioClient.post(
        APIConstants.postPackageDeliver,
        data: formData,
      );

      if (response.statusCode == 200) {
        return (response.data['status'] ?? false) as bool;
      } else {
        return false;
      }
    } on Exception catch (e, s) {
      log('Post Package Delivery Error!', stackTrace: s, error: e);
      return false;
    }
  }
}
