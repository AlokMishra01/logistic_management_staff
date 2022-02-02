import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logistic_management_staff/models/get_vehicle_response_model.dart';
import 'package:logistic_management_staff/models/route_response_model.dart';

import '../controllers/dio_controller.dart';

class RouteService {
  static RouteService service = RouteService();

  Future<RouteResponseModel?> getRoute({required DioController dio}) async {
    try {
      Response response = await dio.dioClient.get(
        'staff/route/vehicle',
      );

      if (response.statusCode == 200) {
        final data = RouteResponseModel.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Route Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<GetVehicleResponseModel?> getVehicle(
      {required DioController dio}) async {
    try {
      Response response = await dio.dioClient.get('staff/route/vehicle');

      if (response.statusCode == 200) {
        final data = GetVehicleResponseModel.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Vehicle Error!', stackTrace: s, error: e);
      return null;
    }
  }
}
