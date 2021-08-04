class StaffModel {
  int? id;
  String? email;
  String? name;
  String? address;
  String? license;
  String? licensePhoto;
  String? phone;
  String? experience;
  String? reference;
  String? photo;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? loginStat;

  StaffModel(
      {this.id,
      this.email,
      this.name,
      this.address,
      this.license,
      this.licensePhoto,
      this.phone,
      this.experience,
      this.reference,
      this.photo,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.loginStat});

  StaffModel.fromJson(dynamic json) {
    id = json["id"];
    email = json["email"];
    name = json["name"];
    address = json["address"];
    license = json["license"];
    licensePhoto = json["license_photo"];
    phone = json["phone"];
    experience = json["experience"];
    reference = json["reference"];
    photo = json["photo"];
    userId = json["user_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    loginStat = json["login_stat"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["address"] = address;
    map["license"] = license;
    map["license_photo"] = licensePhoto;
    map["phone"] = phone;
    map["experience"] = experience;
    map["reference"] = reference;
    map["photo"] = photo;
    map["user_id"] = userId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["login_stat"] = loginStat;
    return map;
  }
}
