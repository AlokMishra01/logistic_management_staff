/// status : true
/// status_code : 200
/// message : "Route Detail"
/// data : {"id":1,"route_title":"Ringroad Kathmandu","route_description":"Ringroad inside","route_points":"[{\"lat\":27.722906808483685,\"lng\":85.30533182525633},{\"lat\":27.718120090212437,\"lng\":85.30541765594481},{\"lat\":27.71523276172298,\"lng\":85.30825006866453},{\"lat\":27.713865053126103,\"lng\":85.31760561370848},{\"lat\":27.714989789822273,\"lng\":85.32634735107422},{\"lat\":27.717664201322656,\"lng\":85.32498705291746},{\"lat\":27.725641981716723,\"lng\":85.31048166656493},{\"lat\":27.725034171373057,\"lng\":85.32215464019774},{\"lat\":27.725641981716723,\"lng\":85.30696260833739},{\"lat\":27.724274403677942,\"lng\":85.30936586761473}]"}

class RouteResponseModel {
  RouteResponseModel({
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

  RouteResponseModel.fromJson(dynamic json) {
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

/// id : 1
/// route_title : "Ringroad Kathmandu"
/// route_description : "Ringroad inside"
/// route_points : "[{\"lat\":27.722906808483685,\"lng\":85.30533182525633},{\"lat\":27.718120090212437,\"lng\":85.30541765594481},{\"lat\":27.71523276172298,\"lng\":85.30825006866453},{\"lat\":27.713865053126103,\"lng\":85.31760561370848},{\"lat\":27.714989789822273,\"lng\":85.32634735107422},{\"lat\":27.717664201322656,\"lng\":85.32498705291746},{\"lat\":27.725641981716723,\"lng\":85.31048166656493},{\"lat\":27.725034171373057,\"lng\":85.32215464019774},{\"lat\":27.725641981716723,\"lng\":85.30696260833739},{\"lat\":27.724274403677942,\"lng\":85.30936586761473}]"

class Data {
  Data({
    int? id,
    String? routeTitle,
    String? routeDescription,
    String? routePoints,
  }) {
    _id = id;
    _routeTitle = routeTitle;
    _routeDescription = routeDescription;
    _routePoints = routePoints;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _routeTitle = json['route_title'];
    _routeDescription = json['route_description'];
    _routePoints = json['route_points'];
  }
  int? _id;
  String? _routeTitle;
  String? _routeDescription;
  String? _routePoints;

  int? get id => _id;
  String? get routeTitle => _routeTitle;
  String? get routeDescription => _routeDescription;
  String? get routePoints => _routePoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['route_title'] = _routeTitle;
    map['route_description'] = _routeDescription;
    map['route_points'] = _routePoints;
    return map;
  }
}
