import 'dart:developer';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../controllers/dio_controller.dart';

class DeliveryService {
  static DeliveryService service = DeliveryService();

  getDeliveries({required DioController dio}) async {
    try {
      Response response = await dio.dioClient.get(APIConstants.deliveryList);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e, s) {
      return '';
    } on Exception catch (e, s) {
      log('Get Deliveries Error!', stackTrace: s, error: e);
      return '';
    }
  }

  postPackageDelivery({
    required DioController dio,
    required int packageId,
    required int dispatchId,
    required String imagePath,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        APIConstants.postPackageDeliver,
        data: {
          'package_id': packageId,
          'dispatch_id': dispatchId,
          'file': MultipartFile.fromFile(imagePath),
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e, s) {
      return '';
    } on Exception catch (e, s) {
      log('Post Package Delivery Error!', stackTrace: s, error: e);
      return '';
    }
  }
}
