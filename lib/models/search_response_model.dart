import 'assigned_response_model.dart';

/// status : true
/// status_code : 200
/// message : "Delivered List"
/// data : [{"id":42,"dispatch_id":17,"sender_name":"test sender1","sender_address":"kathmandu","sender_mobileno":9876543210,"sender_lat":"27.72419012","sender_lon":"85.33824789","reciever_name":"test receiver 1","reciever_address":"kathmandu","reciever_mobileno":9998889890,"reciever_lat":"27.69166707","reciever_lon":"85.29773581","package_type":"Document","package_weight":10,"package_size":1,"pickup_time":"12:01:00","dropoff_time":"12:00:00","fragile":false,"package_price":150,"express":false,"status":"Dispatched"},{"id":31,"dispatch_id":17,"sender_name":"Sumit Anand","sender_address":"Kathmandu","sender_mobileno":9878997898,"sender_lat":"27.71058266","sender_lon":"85.34866333","reciever_name":"Deep Mishra","reciever_address":"Baneshwor","reciever_mobileno":9878997898,"reciever_lat":"27.73482639","reciever_lon":"85.40382254","package_type":"Parcel","package_weight":2,"package_size":300,"pickup_time":"09:00:00","dropoff_time":"08:00:00","fragile":false,"package_price":150,"express":false,"status":"Dispatched"}]

class SearchResponseModel {
  SearchResponseModel({
    bool? status,
    int? statusCode,
    String? message,
    List<AssignedModel>? data,
  }) {
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  SearchResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AssignedModel.fromJson(v));
      });
    }
  }
  bool? _status;
  int? _statusCode;
  String? _message;
  List<AssignedModel>? _data;

  bool? get status => _status;
  int? get statusCode => _statusCode;
  String? get message => _message;
  List<AssignedModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
