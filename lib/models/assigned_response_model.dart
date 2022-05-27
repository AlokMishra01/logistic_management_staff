/// status : true
/// status_code : 200
/// message : "Delivered List"
/// data : {"current_page":1,"last_page":1,"total":2,"data":[{"id":12,"dispatch_id":9,"sender_name":"Sunil","sender_address":"Thapathali","sender_mobileno":9877890000,"sender_lat":"27.69036038","sender_lon":"85.31718761","reciever_name":"Divya","reciever_address":"Chabahil","reciever_mobileno":9871231230,"reciever_lat":"27.71646222","reciever_lon":"85.34810933","package_type":"Electronics","package_weight":2,"package_size":600,"pickup_time":"18:00:00","dropoff_time":"14:00:00","fragile":true,"package_price":0.0,"express":false,"status":"Dispatched"},{"id":13,"dispatch_id":9,"sender_name":"Shrijan","sender_address":"Kathmandu","sender_mobileno":9089878909,"sender_lat":"27.71390804","sender_lon":"85.32314169","reciever_name":"Hari","reciever_address":"Bhaktapur","reciever_mobileno":9089878909,"reciever_lat":"27.66320548","reciever_lon":"85.43400152","package_type":"Electronics","package_weight":1,"package_size":300,"pickup_time":"12:00:00","dropoff_time":"14:00:00","fragile":false,"package_price":null,"express":false,"status":"Dispatched"}]}

class AssignedResponseModel {
  AssignedResponseModel({
    bool? status,
    int? statusCode,
    String? message,
    AssignedData? data,
  }) {
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  AssignedResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null ? AssignedData.fromJson(json['data']) : null;
  }
  bool? _status;
  int? _statusCode;
  String? _message;
  AssignedData? _data;

  bool? get status => _status;
  int? get statusCode => _statusCode;
  String? get message => _message;
  AssignedData? get data => _data;

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
/// total : 2
/// data : [{"id":12,"dispatch_id":9,"sender_name":"Sunil","sender_address":"Thapathali","sender_mobileno":9877890000,"sender_lat":"27.69036038","sender_lon":"85.31718761","reciever_name":"Divya","reciever_address":"Chabahil","reciever_mobileno":9871231230,"reciever_lat":"27.71646222","reciever_lon":"85.34810933","package_type":"Electronics","package_weight":2,"package_size":600,"pickup_time":"18:00:00","dropoff_time":"14:00:00","fragile":true,"package_price":0.0,"express":false,"status":"Dispatched"},{"id":13,"dispatch_id":9,"sender_name":"Shrijan","sender_address":"Kathmandu","sender_mobileno":9089878909,"sender_lat":"27.71390804","sender_lon":"85.32314169","reciever_name":"Hari","reciever_address":"Bhaktapur","reciever_mobileno":9089878909,"reciever_lat":"27.66320548","reciever_lon":"85.43400152","package_type":"Electronics","package_weight":1,"package_size":300,"pickup_time":"12:00:00","dropoff_time":"14:00:00","fragile":false,"package_price":null,"express":false,"status":"Dispatched"}]

class AssignedData {
  AssignedData({
    int? currentPage,
    int? lastPage,
    int? total,
    List<AssignedModel>? assignedList,
  }) {
    _currentPage = currentPage;
    _lastPage = lastPage;
    _total = total;
    _assignedList = assignedList;
  }

  AssignedData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _lastPage = json['last_page'];
    _total = json['total'];
    if (json['data'] != null) {
      _assignedList = [];
      json['data'].forEach((v) {
        _assignedList?.add(AssignedModel.fromJson(v));
      });
    }
  }
  int? _currentPage;
  int? _lastPage;
  int? _total;
  List<AssignedModel>? _assignedList;

  int? get currentPage => _currentPage;
  int? get lastPage => _lastPage;
  int? get total => _total;
  List<AssignedModel>? get assignedList => _assignedList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['last_page'] = _lastPage;
    map['total'] = _total;
    if (_assignedList != null) {
      map['data'] = _assignedList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 12
/// dispatch_id : 9
/// sender_name : "Sunil"
/// sender_address : "Thapathali"
/// sender_mobileno : 9877890000
/// sender_lat : "27.69036038"
/// sender_lon : "85.31718761"
/// reciever_name : "Divya"
/// reciever_address : "Chabahil"
/// reciever_mobileno : 9871231230
/// reciever_lat : "27.71646222"
/// reciever_lon : "85.34810933"
/// package_type : "Electronics"
/// package_weight : 2
/// package_size : 600
/// pickup_time : "18:00:00"
/// dropoff_time : "14:00:00"
/// fragile : true
/// package_price : 0.0
/// express : false
/// status : "Dispatched"

class AssignedModel {
  AssignedModel({
    int? id,
    int? dispatchId,
    String? senderName,
    String? senderAddress,
    String? senderMobileno,
    String? senderLat,
    String? senderLon,
    String? recieverName,
    String? recieverAddress,
    String? recieverMobileno,
    String? recieverLat,
    String? recieverLon,
    String? packageType,
    String? packageWeight,
    String? packageSize,
    String? pickupTime,
    String? dropoffTime,
    bool? fragile,
    String? packagePrice,
    bool? express,
    String? status,
    String? packageCode,
  }) {
    _id = id;
    _dispatchId = dispatchId;
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

  AssignedModel.fromJson(dynamic json) {
    _id = json['id'];
    _dispatchId = json['dispatch_id'];
    _senderName = (json['sender_name'] ?? '').toString();
    _senderAddress = (json['sender_address'] ?? '').toString();
    _senderMobileno = (json['sender_mobileno'] ?? '').toString();
    _senderLat = (json['sender_lat'] ?? '').toString();
    _senderLon = (json['sender_lon'] ?? '').toString();
    _recieverName = (json['reciever_name'] ?? '').toString();
    _recieverAddress = (json['reciever_address'] ?? '').toString();
    _recieverMobileno = (json['reciever_mobileno'] ?? '').toString();
    _recieverLat = (json['reciever_lat'] ?? '').toString();
    _recieverLon = (json['reciever_lon'] ?? '').toString();
    _packageType = (json['package_type'] ?? '').toString();
    _packageWeight = (json['package_weight'] ?? '').toString();
    _packageSize = (json['package_size'] ?? '').toString();
    _pickupTime = (json['pickup_time'] ?? '').toString();
    _dropoffTime = (json['dropoff_time'] ?? '').toString();
    _fragile = json['fragile'];
    _packagePrice = (json["package_price"] ?? '').toString();
    _express = json['express'];
    _status = (json['status'] ?? '').toString();
    _packageCode = (json['package_code'] ?? '').toString();
  }
  int? _id;
  int? _dispatchId;
  String? _senderName;
  String? _senderAddress;
  String? _senderMobileno;
  String? _senderLat;
  String? _senderLon;
  String? _recieverName;
  String? _recieverAddress;
  String? _recieverMobileno;
  String? _recieverLat;
  String? _recieverLon;
  String? _packageType;
  String? _packageWeight;
  String? _packageSize;
  String? _pickupTime;
  String? _dropoffTime;
  bool? _fragile;
  String? _packagePrice;
  bool? _express;
  String? _status;
  String? _packageCode;

  int? get id => _id;
  int? get dispatchId => _dispatchId;
  String? get senderName => _senderName;
  String? get senderAddress => _senderAddress;
  String? get senderMobileno => _senderMobileno;
  String? get senderLat => _senderLat;
  String? get senderLon => _senderLon;
  String? get recieverName => _recieverName;
  String? get recieverAddress => _recieverAddress;
  String? get recieverMobileno => _recieverMobileno;
  String? get recieverLat => _recieverLat;
  String? get recieverLon => _recieverLon;
  String? get packageType => _packageType;
  String? get packageWeight => _packageWeight;
  String? get packageSize => _packageSize;
  String? get pickupTime => _pickupTime;
  String? get dropoffTime => _dropoffTime;
  bool? get fragile => _fragile;
  String? get packagePrice => _packagePrice;
  bool? get express => _express;
  String? get status => _status;
  String? get packageCode => _packageCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['dispatch_id'] = _dispatchId;
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
