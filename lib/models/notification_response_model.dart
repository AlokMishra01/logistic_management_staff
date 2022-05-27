/// status : true
/// status_code : 200
/// message : "Package/Order History"
/// data : {"current_page":1,"last_page":1,"total":1,"data":[{"id":1,"title":"Hello","description":"This is a test notification","image":"https://logistics.intopros.com.np/","senttime":"2022-01-04 14:18:33","type":"home","status":1}]}

class NotificationResponseModel {
  NotificationResponseModel({
    bool? status,
    int? statusCode,
    String? message,
    NotificationResponseData? data,
  }) {
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  NotificationResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null
        ? NotificationResponseData.fromJson(json['data'])
        : null;
  }
  bool? _status;
  int? _statusCode;
  String? _message;
  NotificationResponseData? _data;

  bool? get status => _status;
  int? get statusCode => _statusCode;
  String? get message => _message;
  NotificationResponseData? get data => _data;

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
/// data : [{"id":1,"title":"Hello","description":"This is a test notification","image":"https://logistics.intopros.com.np/","senttime":"2022-01-04 14:18:33","type":"home","status":1}]

class NotificationResponseData {
  NotificationResponseData({
    int? currentPage,
    int? lastPage,
    int? total,
    List<NotificationData>? data,
  }) {
    _currentPage = currentPage;
    _lastPage = lastPage;
    _total = total;
    _data = data;
  }

  NotificationResponseData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _lastPage = json['last_page'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
  }
  int? _currentPage;
  int? _lastPage;
  int? _total;
  List<NotificationData>? _data;

  int? get currentPage => _currentPage;
  int? get lastPage => _lastPage;
  int? get total => _total;
  List<NotificationData>? get data => _data;

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

/// id : 1
/// title : "Hello"
/// description : "This is a test notification"
/// image : "https://logistics.intopros.com.np/"
/// senttime : "2022-01-04 14:18:33"
/// type : "home"
/// status : 1

class NotificationData {
  NotificationData({
    int? id,
    String? title,
    String? description,
    String? image,
    String? senttime,
    String? type,
    int? status,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _senttime = senttime;
    _type = type;
    _status = status;
  }

  NotificationData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _senttime = json['senttime'];
    _type = json['type'];
    _status = json['status'];
  }
  int? _id;
  String? _title;
  String? _description;
  String? _image;
  String? _senttime;
  String? _type;
  int? _status;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get senttime => _senttime;
  String? get type => _type;
  int? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['senttime'] = _senttime;
    map['type'] = _type;
    map['status'] = _status;
    return map;
  }
}
