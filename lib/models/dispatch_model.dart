class DispatchModel {
  int? dispatchId;
  int? id;
  int? vehicleId;
  int? staffId;
  int? routeId;
  int? occupiedWeight;
  String? volume;
  int? warehouseId;
  int? adminId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? length;
  String? width;
  String? height;
  String? regNo;
  String? photo;
  String? brand;
  String? color;
  String? vin;
  String? engineNo;
  String? capacity;
  int? userId;
  int? packageId;
  String? senderName;
  String? senderAddress;
  String? senderMobileno;
  String? senderLat;
  String? senderLon;
  String? recieverName;
  String? recieverAddress;
  String? recieverMobileno;
  String? recieverLat;
  String? recieverLon;
  String? packageWeight;
  String? packageSize;
  String? pickupTime;
  String? dropoffTime;
  bool? fragile;
  bool? express;
  String? packageLength;
  String? packageHeight;
  String? packageWidth;
  String? dropoffDate;
  int? packageType;
  String? routeTitle;
  String? routeDescription;
  String? routePoints;
  String? name;
  String? email;
  String? phone;
  String? phone2;
  String? manager;
  String? managerPhone;
  String? address;
  String? street;
  String? city;
  String? state;
  String? country;
  String? postalcode;
  String? lat;
  String? lon;
  String? packageCode;

  DispatchModel({
    this.dispatchId,
    this.id,
    this.vehicleId,
    this.staffId,
    this.routeId,
    this.occupiedWeight,
    this.volume,
    this.warehouseId,
    this.adminId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.length,
    this.width,
    this.height,
    this.regNo,
    this.photo,
    this.brand,
    this.color,
    this.vin,
    this.engineNo,
    this.capacity,
    this.userId,
    this.packageId,
    this.senderName,
    this.senderAddress,
    this.senderMobileno,
    this.senderLat,
    this.senderLon,
    this.recieverName,
    this.recieverAddress,
    this.recieverMobileno,
    this.recieverLat,
    this.recieverLon,
    this.packageWeight,
    this.packageSize,
    this.pickupTime,
    this.dropoffTime,
    this.fragile,
    this.express,
    this.packageLength,
    this.packageHeight,
    this.packageWidth,
    this.dropoffDate,
    this.packageType,
    this.routeTitle,
    this.routeDescription,
    this.routePoints,
    this.name,
    this.email,
    this.phone,
    this.phone2,
    this.manager,
    this.managerPhone,
    this.address,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalcode,
    this.lat,
    this.lon,
    this.packageCode,
  });

  DispatchModel.fromJson(dynamic json) {
    dispatchId = json["dispatch_id"];
    id = json["id"];
    vehicleId = json["vehicle_id"];
    staffId = json["staff_id"];
    routeId = json["route_id"];
    occupiedWeight = json["occupied_weight"];
    volume = json["volume"].toString();
    warehouseId = json["warehouse_id"];
    adminId = json["admin_id"];
    status = json["status"].toString();
    createdAt = json["created_at"].toString();
    updatedAt = json["updated_at"].toString();
    length = json["length"].toString();
    width = json["width"].toString();
    height = json["height"].toString();
    regNo = json["reg_no"].toString();
    photo = json["photo"].toString();
    brand = json["brand"].toString();
    color = json["color"].toString();
    vin = json["vin"].toString();
    engineNo = json["engine_no"].toString();
    capacity = json["capacity"].toString();
    userId = json["user_id"];
    packageId = json["package_id"];
    senderName = json["sender_name"].toString();
    senderAddress = json["sender_address"].toString();
    senderMobileno = json["sender_mobileno"].toString();
    senderLat = json["sender_lat"].toString();
    senderLon = json["sender_lon"].toString();
    recieverName = json["reciever_name"].toString();
    recieverAddress = json["reciever_address"].toString();
    recieverMobileno = json["reciever_mobileno"].toString();
    recieverLat = json["reciever_lat"].toString();
    recieverLon = json["reciever_lon"].toString();
    packageWeight = json["package_weight"].toString();
    packageSize = json["package_size"].toString();
    pickupTime = json["pickup_time"].toString();
    dropoffTime = json["dropoff_time"].toString();
    fragile = json["fragile"];
    express = json["express"];
    packageLength = json["package_length"].toString();
    packageHeight = json["package_height"].toString();
    packageWidth = json["package_width"].toString();
    dropoffDate = json["dropoff_date"].toString();
    packageType = json["package_type"];
    routeTitle = json["route_title"].toString();
    routeDescription = json["route_description"].toString();
    routePoints = json["route_points"].toString();
    name = json["name"].toString();
    email = json["email"].toString();
    phone = json["phone"].toString();
    phone2 = json["phone2"].toString();
    manager = json["manager"].toString();
    managerPhone = json["manager_phone"].toString();
    address = json["address"].toString();
    street = json["street"].toString();
    city = json["city"].toString();
    state = json["state"].toString();
    country = json["country"].toString();
    postalcode = json["postalcode"].toString();
    lat = json["lat"].toString();
    lon = json["lon"].toString();
    packageCode = json['package_code'].toString();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["dispatch_id"] = dispatchId;
    map["id"] = id;
    map["vehicle_id"] = vehicleId;
    map["staff_id"] = staffId;
    map["route_id"] = routeId;
    map["occupied_weight"] = occupiedWeight;
    map["volume"] = volume;
    map["warehouse_id"] = warehouseId;
    map["admin_id"] = adminId;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["length"] = length;
    map["width"] = width;
    map["height"] = height;
    map["reg_no"] = regNo;
    map["photo"] = photo;
    map["brand"] = brand;
    map["color"] = color;
    map["vin"] = vin;
    map["engine_no"] = engineNo;
    map["capacity"] = capacity;
    map["user_id"] = userId;
    map["package_id"] = packageId;
    map["sender_name"] = senderName;
    map["sender_address"] = senderAddress;
    map["sender_mobileno"] = senderMobileno;
    map["sender_lat"] = senderLat;
    map["sender_lon"] = senderLon;
    map["reciever_name"] = recieverName;
    map["reciever_address"] = recieverAddress;
    map["reciever_mobileno"] = recieverMobileno;
    map["reciever_lat"] = recieverLat;
    map["reciever_lon"] = recieverLon;
    map["package_weight"] = packageWeight;
    map["package_size"] = packageSize;
    map["pickup_time"] = pickupTime;
    map["dropoff_time"] = dropoffTime;
    map["fragile"] = fragile;
    map["express"] = express;
    map["package_length"] = packageLength;
    map["package_height"] = packageHeight;
    map["package_width"] = packageWidth;
    map["dropoff_date"] = dropoffDate;
    map["package_type"] = packageType;
    map["route_title"] = routeTitle;
    map["route_description"] = routeDescription;
    map["route_points"] = routePoints;
    map["name"] = name;
    map["email"] = email;
    map["phone"] = phone;
    map["phone2"] = phone2;
    map["manager"] = manager;
    map["manager_phone"] = managerPhone;
    map["address"] = address;
    map["street"] = street;
    map["city"] = city;
    map["state"] = state;
    map["country"] = country;
    map["postalcode"] = postalcode;
    map["lat"] = lat;
    map["lon"] = lon;
    map['package_code'] = packageCode;
    return map;
  }
}
