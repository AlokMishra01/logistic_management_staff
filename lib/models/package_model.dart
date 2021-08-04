class PackageModel {
  int? id;
  String? senderName;
  String? senderAddress;
  String? senderMobileNo;
  String? senderLat;
  String? senderLon;
  String? receiverName;
  String? receiverAddress;
  String? receiverMobileNo;
  String? receiverLat;
  String? receiverLon;
  String? packageType;
  String? packageWeight;
  String? packageSize;
  String? pickupTime;
  String? dropOffTime;
  bool? fragile;
  String? packagePrice;
  bool? express;
  String? createdAt;
  String? updatedAt;
  int? userId;

  PackageModel({
    this.id,
    this.senderName,
    this.senderAddress,
    this.senderMobileNo,
    this.senderLat,
    this.senderLon,
    this.receiverName,
    this.receiverAddress,
    this.receiverMobileNo,
    this.receiverLat,
    this.receiverLon,
    this.packageType,
    this.packageWeight,
    this.packageSize,
    this.pickupTime,
    this.dropOffTime,
    this.fragile,
    this.packagePrice,
    this.express,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  PackageModel.fromJson(dynamic json) {
    id = json["id"];
    senderName = json["sender_name"].toString();
    senderAddress = json["sender_address"].toString();
    senderMobileNo = json["sender_mobileno"].toString();
    senderLat = json["sender_lat"].toString();
    senderLon = json["sender_lon"].toString();
    receiverName = json["reciever_name"].toString();
    receiverAddress = json["reciever_address"].toString();
    receiverMobileNo = json["reciever_mobileno"].toString();
    receiverLat = json["reciever_lat"].toString();
    receiverLon = json["reciever_lon"].toString();
    packageType = json["package_type"].toString();
    packageWeight = json["package_weight"].toString();
    packageSize = json["package_size"].toString();
    pickupTime = json["pickup_time"].toString();
    dropOffTime = json["dropoff_time"].toString();
    fragile = json["fragile"];
    packagePrice = json["package_price"].toString();
    express = json["express"];
    createdAt = json["created_at"].toString();
    updatedAt = json["updated_at"].toString();
    userId = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sender_name"] = senderName;
    map["sender_address"] = senderAddress;
    map["sender_mobileno"] = senderMobileNo;
    map["sender_lat"] = senderLat;
    map["sender_lon"] = senderLon;
    map["reciever_name"] = receiverName;
    map["reciever_address"] = receiverAddress;
    map["reciever_mobileno"] = receiverMobileNo;
    map["reciever_lat"] = receiverLat;
    map["reciever_lon"] = receiverLon;
    map["package_type"] = packageType;
    map["package_weight"] = packageWeight;
    map["package_size"] = packageSize;
    map["pickup_time"] = pickupTime;
    map["dropoff_time"] = dropOffTime;
    map["fragile"] = fragile;
    map["package_price"] = packagePrice;
    map["express"] = express;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["user_id"] = userId;
    return map;
  }
}
