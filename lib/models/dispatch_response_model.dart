import 'package:logistic_management_staff/models/assigned_response_model.dart';

/// status : true
/// status_code : 200
/// message : "Delivered List"
/// data : {"dispatches":[{"id":37,"sender_name":"Alok Mishra","sender_address":"Sankhamul, Kathamandu","sender_mobileno":9869050723,"sender_lat":"27.68264511","sender_lon":"85.33772528","reciever_name":"Akhilesh Mishra","reciever_address":"Lokanthali, Bhaktapur","reciever_mobileno":9869050723,"reciever_lat":"27.67451543","reciever_lon":"85.36968917","package_type":"Parcel","package_weight":500,"package_size":1000000,"pickup_time":"10:00:00","dropoff_time":"17:00:00","fragile":true,"package_price":2300,"express":true,"status":"Picked Up","price":null}],"picked_up":[{"id":37,"sender_name":"Alok Mishra","sender_address":"Sankhamul, Kathamandu","sender_mobileno":9869050723,"sender_lat":"27.68264511","sender_lon":"85.33772528","reciever_name":"Akhilesh Mishra","reciever_address":"Lokanthali, Bhaktapur","reciever_mobileno":9869050723,"reciever_lat":"27.67451543","reciever_lon":"85.36968917","package_type":"Parcel","package_weight":500,"package_size":1000000,"pickup_time":"10:00:00","dropoff_time":"17:00:00","fragile":true,"package_price":2300,"express":true,"status":"Picked Up","price":null}]}

class DispatchResponseModel {
  DispatchResponseModel({
    bool? status,
    int? statusCode,
    String? message,
    Data? data,
  }) {
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  DispatchResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  int? _statusCode;
  String? _message;
  Data? _data;

  bool? get status => _status;
  int? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// dispatches : [{"id":37,"sender_name":"Alok Mishra","sender_address":"Sankhamul, Kathamandu","sender_mobileno":9869050723,"sender_lat":"27.68264511","sender_lon":"85.33772528","reciever_name":"Akhilesh Mishra","reciever_address":"Lokanthali, Bhaktapur","reciever_mobileno":9869050723,"reciever_lat":"27.67451543","reciever_lon":"85.36968917","package_type":"Parcel","package_weight":500,"package_size":1000000,"pickup_time":"10:00:00","dropoff_time":"17:00:00","fragile":true,"package_price":2300,"express":true,"status":"Picked Up","price":null}]
/// picked_up : [{"id":37,"sender_name":"Alok Mishra","sender_address":"Sankhamul, Kathamandu","sender_mobileno":9869050723,"sender_lat":"27.68264511","sender_lon":"85.33772528","reciever_name":"Akhilesh Mishra","reciever_address":"Lokanthali, Bhaktapur","reciever_mobileno":9869050723,"reciever_lat":"27.67451543","reciever_lon":"85.36968917","package_type":"Parcel","package_weight":500,"package_size":1000000,"pickup_time":"10:00:00","dropoff_time":"17:00:00","fragile":true,"package_price":2300,"express":true,"status":"Picked Up","price":null}]

class Data {
  Data({
    List<AssignedModel>? dispatches,
    List<AssignedModel>? pickedUp,
  }) {
    _dispatches = dispatches;
    _pickedUp = pickedUp;
  }

  Data.fromJson(dynamic json) {
    if (json['dispatches'] != null) {
      _dispatches = [];
      json['dispatches'].forEach((v) {
        _dispatches?.add(AssignedModel.fromJson(v));
      });
    }
    if (json['picked_up'] != null) {
      _pickedUp = [];
      json['picked_up'].forEach((v) {
        _pickedUp?.add(AssignedModel.fromJson(v));
      });
    }
  }
  List<AssignedModel>? _dispatches;
  List<AssignedModel>? _pickedUp;

  List<AssignedModel>? get dispatches => _dispatches;
  List<AssignedModel>? get pickedUp => _pickedUp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dispatches != null) {
      map['dispatches'] = _dispatches?.map((v) => v.toJson()).toList();
    }
    if (_pickedUp != null) {
      map['picked_up'] = _pickedUp?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
