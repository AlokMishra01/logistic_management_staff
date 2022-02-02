/// status : true
/// status_code : 200
/// message : "Route Detail"
/// data : {"route":{"id":1,"route_title":"Ringroad Kathmandu","route_description":"Ringroad inside","route_points":"[{\"lat\":27.722906808483685,\"lng\":85.30533182525633},{\"lat\":27.718120090212437,\"lng\":85.30541765594481},{\"lat\":27.71523276172298,\"lng\":85.30825006866453},{\"lat\":27.713865053126103,\"lng\":85.31760561370848},{\"lat\":27.714989789822273,\"lng\":85.32634735107422},{\"lat\":27.717664201322656,\"lng\":85.32498705291746},{\"lat\":27.725641981716723,\"lng\":85.31048166656493},{\"lat\":27.725034171373057,\"lng\":85.32215464019774},{\"lat\":27.725641981716723,\"lng\":85.30696260833739},{\"lat\":27.724274403677942,\"lng\":85.30936586761473}]"},"vehicle":{"id":6,"reg_no":"TATA-315","brand":"TATA","color":"White","vin":"VIN456","engine_no":"ENG987","capacity":"1000","volume":"10000"}}

class GetVehicleResponseModel {
  GetVehicleResponseModel({
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

  GetVehicleResponseModel.fromJson(dynamic json) {
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

/// route : {"id":1,"route_title":"Ringroad Kathmandu","route_description":"Ringroad inside","route_points":"[{\"lat\":27.722906808483685,\"lng\":85.30533182525633},{\"lat\":27.718120090212437,\"lng\":85.30541765594481},{\"lat\":27.71523276172298,\"lng\":85.30825006866453},{\"lat\":27.713865053126103,\"lng\":85.31760561370848},{\"lat\":27.714989789822273,\"lng\":85.32634735107422},{\"lat\":27.717664201322656,\"lng\":85.32498705291746},{\"lat\":27.725641981716723,\"lng\":85.31048166656493},{\"lat\":27.725034171373057,\"lng\":85.32215464019774},{\"lat\":27.725641981716723,\"lng\":85.30696260833739},{\"lat\":27.724274403677942,\"lng\":85.30936586761473}]"}
/// vehicle : {"id":6,"reg_no":"TATA-315","brand":"TATA","color":"White","vin":"VIN456","engine_no":"ENG987","capacity":"1000","volume":"10000"}

class Data {
  Data({
    Route? route,
    Vehicle? vehicle,
  }) {
    _route = route;
    _vehicle = vehicle;
  }

  Data.fromJson(dynamic json) {
    _route = json['route'] != null ? Route.fromJson(json['route']) : null;
    _vehicle =
        json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }
  Route? _route;
  Vehicle? _vehicle;

  Route? get route => _route;
  Vehicle? get vehicle => _vehicle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_route != null) {
      map['route'] = _route?.toJson();
    }
    if (_vehicle != null) {
      map['vehicle'] = _vehicle?.toJson();
    }
    return map;
  }
}

/// id : 6
/// reg_no : "TATA-315"
/// brand : "TATA"
/// color : "White"
/// vin : "VIN456"
/// engine_no : "ENG987"
/// capacity : "1000"
/// volume : "10000"

class Vehicle {
  Vehicle({
    int? id,
    String? regNo,
    String? brand,
    String? color,
    String? vin,
    String? engineNo,
    String? capacity,
    String? volume,
  }) {
    _id = id;
    _regNo = regNo;
    _brand = brand;
    _color = color;
    _vin = vin;
    _engineNo = engineNo;
    _capacity = capacity;
    _volume = volume;
  }

  Vehicle.fromJson(dynamic json) {
    _id = json['id'];
    _regNo = json['reg_no'];
    _brand = json['brand'];
    _color = json['color'];
    _vin = json['vin'];
    _engineNo = json['engine_no'];
    _capacity = json['capacity'];
    _volume = json['volume'];
  }
  int? _id;
  String? _regNo;
  String? _brand;
  String? _color;
  String? _vin;
  String? _engineNo;
  String? _capacity;
  String? _volume;

  int? get id => _id;
  String? get regNo => _regNo;
  String? get brand => _brand;
  String? get color => _color;
  String? get vin => _vin;
  String? get engineNo => _engineNo;
  String? get capacity => _capacity;
  String? get volume => _volume;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reg_no'] = _regNo;
    map['brand'] = _brand;
    map['color'] = _color;
    map['vin'] = _vin;
    map['engine_no'] = _engineNo;
    map['capacity'] = _capacity;
    map['volume'] = _volume;
    return map;
  }
}

/// id : 1
/// route_title : "Ringroad Kathmandu"
/// route_description : "Ringroad inside"
/// route_points : "[{\"lat\":27.722906808483685,\"lng\":85.30533182525633},{\"lat\":27.718120090212437,\"lng\":85.30541765594481},{\"lat\":27.71523276172298,\"lng\":85.30825006866453},{\"lat\":27.713865053126103,\"lng\":85.31760561370848},{\"lat\":27.714989789822273,\"lng\":85.32634735107422},{\"lat\":27.717664201322656,\"lng\":85.32498705291746},{\"lat\":27.725641981716723,\"lng\":85.31048166656493},{\"lat\":27.725034171373057,\"lng\":85.32215464019774},{\"lat\":27.725641981716723,\"lng\":85.30696260833739},{\"lat\":27.724274403677942,\"lng\":85.30936586761473}]"

class Route {
  Route({
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

  Route.fromJson(dynamic json) {
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
