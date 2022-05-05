class RequestModel {
  int? id;
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
  String? packageType;
  String? packageWeight;
  String? packageSize;
  String? pickupTime;
  String? dropoffTime;
  int? assignid;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? deletedAt;
  int? packageLength;
  int? packageWidth;
  int? packageHeight;
  int? fragile;
  int? express;
  int? status;
  String? pickupDate;
  String? dropoffDate;
  String? packageCode;

  RequestModel({
    this.id,
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
    this.packageType,
    this.packageWeight,
    this.packageSize,
    this.pickupTime,
    this.dropoffTime,
    this.assignid,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.deletedAt,
    this.packageLength,
    this.packageWidth,
    this.packageHeight,
    this.fragile,
    this.express,
    this.status,
    this.pickupDate,
    this.dropoffDate,
    this.packageCode,
  });

  RequestModel.fromJson(dynamic json) {
    id = json["id"];
    senderName = json["sender_name"];
    senderAddress = json["sender_address"];
    senderMobileno = json["sender_mobileno"];
    senderLat = json["sender_lat"];
    senderLon = json["sender_lon"];
    recieverName = json["reciever_name"];
    recieverAddress = json["reciever_address"];
    recieverMobileno = json["reciever_mobileno"];
    recieverLat = json["reciever_lat"];
    recieverLon = json["reciever_lon"];
    packageType = json["package_type"];
    packageWeight = json["package_weight"];
    packageSize = json["package_size"];
    pickupTime = json["pickup_time"];
    dropoffTime = json["dropoff_time"];
    assignid = json["assignid"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    userId = json["user_id"];
    deletedAt = json["deleted_at"];
    packageLength = json["package_length"];
    packageWidth = json["package_width"];
    packageHeight = json["package_height"];
    fragile = json["fragile"];
    express = json["express"];
    status = json["status"];
    pickupDate = json["pickup_date"];
    dropoffDate = json["dropoff_date"];
    packageCode = json['package_code'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
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
    map["package_type"] = packageType;
    map["package_weight"] = packageWeight;
    map["package_size"] = packageSize;
    map["pickup_time"] = pickupTime;
    map["dropoff_time"] = dropoffTime;
    map["assignid"] = assignid;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["user_id"] = userId;
    map["deleted_at"] = deletedAt;
    map["package_length"] = packageLength;
    map["package_width"] = packageWidth;
    map["package_height"] = packageHeight;
    map["fragile"] = fragile;
    map["express"] = express;
    map["status"] = status;
    map["pickup_date"] = pickupDate;
    map["dropoff_date"] = dropoffDate;
    map['package_code'] = packageCode;
    return map;
  }
}
