/// status : true
/// status_code : 200
/// message : "Pick up list"
/// data : {"current_page":1,"last_page":1,"total":1,"data":[{"id":9,"sender_name":"Rabin Sapkotas","sender_address":"M9F4+JW Madhyapur Thimi, Nepal","sender_mobileno":9843053083,"sender_lat":"27.67400520","sender_lon":"85.35728085","reciever_name":"Rajesh Devkota","reciever_address":"Lele 44700, Nepal","reciever_mobileno":9841012012,"reciever_lat":"27.57608640","reciever_lon":"85.31498778","package_type":"Document","package_weight":1,"package_size":10,"pickup_time":"10:30:00","dropoff_time":"10:30:00","fragile":true,"package_price":10.0,"express":false,"status":"In Transit"}]}

class PickupResponseModel {
  PickupResponseModel({
    bool? status,
    int? statusCode,
    String? message,
    PickupResponseData? data,
  }) {
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  PickupResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data =
        json['data'] != null ? PickupResponseData.fromJson(json['data']) : null;
  }
  bool? _status;
  int? _statusCode;
  String? _message;
  PickupResponseData? _data;

  bool? get status => _status;
  int? get statusCode => _statusCode;
  String? get message => _message;
  PickupResponseData? get data => _data;

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

/// current_page : 1
/// last_page : 1
/// total : 1
/// data : [{"id":9,"sender_name":"Rabin Sapkotas","sender_address":"M9F4+JW Madhyapur Thimi, Nepal","sender_mobileno":9843053083,"sender_lat":"27.67400520","sender_lon":"85.35728085","reciever_name":"Rajesh Devkota","reciever_address":"Lele 44700, Nepal","reciever_mobileno":9841012012,"reciever_lat":"27.57608640","reciever_lon":"85.31498778","package_type":"Document","package_weight":1,"package_size":10,"pickup_time":"10:30:00","dropoff_time":"10:30:00","fragile":true,"package_price":10.0,"express":false,"status":"In Transit"}]

class PickupResponseData {
  PickupResponseData({
    int? currentPage,
    int? lastPage,
    int? total,
    List<PickupDataModel>? data,
  }) {
    _currentPage = currentPage;
    _lastPage = lastPage;
    _total = total;
    _data = data;
  }

  PickupResponseData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _lastPage = json['last_page'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PickupDataModel.fromJson(v));
      });
    }
  }
  int? _currentPage;
  int? _lastPage;
  int? _total;
  List<PickupDataModel>? _data;

  int? get currentPage => _currentPage;
  int? get lastPage => _lastPage;
  int? get total => _total;
  List<PickupDataModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['last_page'] = _lastPage;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 9
/// sender_name : "Rabin Sapkotas"
/// sender_address : "M9F4+JW Madhyapur Thimi, Nepal"
/// sender_mobileno : 9843053083
/// sender_lat : "27.67400520"
/// sender_lon : "85.35728085"
/// reciever_name : "Rajesh Devkota"
/// reciever_address : "Lele 44700, Nepal"
/// reciever_mobileno : 9841012012
/// reciever_lat : "27.57608640"
/// reciever_lon : "85.31498778"
/// package_type : "Document"
/// package_weight : 1
/// package_size : 10
/// pickup_time : "10:30:00"
/// dropoff_time : "10:30:00"
/// fragile : true
/// package_price : 10.0
/// express : false
/// status : "In Transit"

class PickupDataModel {
  PickupDataModel({
    int? id,
    String? senderName,
    String? senderAddress,
    int? senderMobileno,
    String? senderLat,
    String? senderLon,
    String? recieverName,
    String? recieverAddress,
    int? recieverMobileno,
    String? recieverLat,
    String? recieverLon,
    String? packageType,
    int? packageWeight,
    int? packageSize,
    String? pickupTime,
    String? dropoffTime,
    bool? fragile,
    double? packagePrice,
    bool? express,
    String? status,
    String? packageCode,
  }) {
    _id = id;
    _senderName = senderName;
    _senderAddress = senderAddress;
    _senderMobileno = senderMobileno;
    _senderLat = senderLat;
    _senderLon = senderLon;
    _recieverName = recieverName;
    _recieverAddress = recieverAddress;
    _recieverMobileno = recieverMobileno;
    _recieverLat = recieverLat;
    _recieverLon = recieverLon;
    _packageType = packageType;
    _packageWeight = packageWeight;
    _packageSize = packageSize;
    _pickupTime = pickupTime;
    _dropoffTime = dropoffTime;
    _fragile = fragile;
    _packagePrice = packagePrice;
    _express = express;
    _status = status;
    _packageCode = packageCode;
  }

  PickupDataModel.fromJson(dynamic json) {
    _id = json['id'];
    _senderName = json['sender_name'];
    _senderAddress = json['sender_address'];
    _senderMobileno = json['sender_mobileno'];
    _senderLat = json['sender_lat'];
    _senderLon = json['sender_lon'];
    _recieverName = json['reciever_name'];
    _recieverAddress = json['reciever_address'];
    _recieverMobileno = json['reciever_mobileno'];
    _recieverLat = json['reciever_lat'];
    _recieverLon = json['reciever_lon'];
    _packageType = json['package_type'];
    _packageWeight = json['package_weight'];
    _packageSize = json['package_size'];
    _pickupTime = json['pickup_time'];
    _dropoffTime = json['dropoff_time'];
    _fragile = json['fragile'];
    _packagePrice = double.parse((json['package_price'] ?? 0.0).toString());
    _express = json['express'];
    _status = json['status'];
    _packageCode = json['package_code'];
  }
  int? _id;
  String? _senderName;
  String? _senderAddress;
  int? _senderMobileno;
  String? _senderLat;
  String? _senderLon;
  String? _recieverName;
  String? _recieverAddress;
  int? _recieverMobileno;
  String? _recieverLat;
  String? _recieverLon;
  String? _packageType;
  int? _packageWeight;
  int? _packageSize;
  String? _pickupTime;
  String? _dropoffTime;
  bool? _fragile;
  double? _packagePrice;
  bool? _express;
  String? _status;
  String? _packageCode;

  int? get id => _id;
  String? get senderName => _senderName;
  String? get senderAddress => _senderAddress;
  int? get senderMobileno => _senderMobileno;
  String? get senderLat => _senderLat;
  String? get senderLon => _senderLon;
  String? get recieverName => _recieverName;
  String? get recieverAddress => _recieverAddress;
  int? get recieverMobileno => _recieverMobileno;
  String? get recieverLat => _recieverLat;
  String? get recieverLon => _recieverLon;
  String? get packageType => _packageType;
  int? get packageWeight => _packageWeight;
  int? get packageSize => _packageSize;
  String? get pickupTime => _pickupTime;
  String? get dropoffTime => _dropoffTime;
  bool? get fragile => _fragile;
  double? get packagePrice => _packagePrice;
  bool? get express => _express;
  String? get status => _status;
  String? get packageCode => _packageCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sender_name'] = _senderName;
    map['sender_address'] = _senderAddress;
    map['sender_mobileno'] = _senderMobileno;
    map['sender_lat'] = _senderLat;
    map['sender_lon'] = _senderLon;
    map['reciever_name'] = _recieverName;
    map['reciever_address'] = _recieverAddress;
    map['reciever_mobileno'] = _recieverMobileno;
    map['reciever_lat'] = _recieverLat;
    map['reciever_lon'] = _recieverLon;
    map['package_type'] = _packageType;
    map['package_weight'] = _packageWeight;
    map['package_size'] = _packageSize;
    map['pickup_time'] = _pickupTime;
    map['dropoff_time'] = _dropoffTime;
    map['fragile'] = _fragile;
    map['package_price'] = _packagePrice;
    map['express'] = _express;
    map['status'] = _status;
    map['package_code'] = _packageCode;
    return map;
  }
}
