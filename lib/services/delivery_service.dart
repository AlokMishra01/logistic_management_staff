import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logistic_management_staff/models/assigned_response_model.dart';
import 'package:logistic_management_staff/models/dispatch_response_model.dart';
import 'package:logistic_management_staff/models/search_response_model.dart';
import 'package:pretty_json/pretty_json.dart';

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

  Future<DispatchResponseModel?> getPickUpDispatchList({
    required DioController dio,
    int limit = 100,
  }) async {
    try {
      Response response = await dio.dioClient.get(
        'staff/assgined/pickedup_dispatch?limit=$limit',
      );
      log('Get Dispatch Response! ${response.requestOptions.uri.toString()}: ${prettyJson(response.data)}');
      if (response.statusCode == 200) {
        final data = DispatchResponseModel.fromJson(response.data);
        log('Testing ' + prettyJson(data.toJson()));
        return data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Dispatch Error!', stackTrace: s, error: e);
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
        'delivered_image': await MultipartFile.fromFile(imagePath),
      });

      Response response = await dio.dioClient.post(
        APIConstants.postPackageDeliver,
        data: formData,
      );

      log(
        'Post Package Delivery Response => ${response.statusCode}: ${prettyJson(response.data)}',
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

  Future<SearchResponseModel?> searchPackageList({
    required DioController dio,
    required String query,
    bool isDispatch = true,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'staff/package/search',
        data: {
          'type': isDispatch ? 'Dispatch' : 'Picked Up',
          'keyword': query,
        },
      );

      if (response.statusCode == 200) {
        final data = SearchResponseModel.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Search Package Error!', stackTrace: s, error: e);
      return null;
    }
  }
}
