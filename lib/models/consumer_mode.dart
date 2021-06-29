class ConsumerModel {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? mobile;
  String? token;

  ConsumerModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.mobile,
    this.token,
  });

  ConsumerModel.fromJson(dynamic json) {
    id = json["id"];
    firstname = json["firstname"];
    lastname = json["lastname"];
    email = json["email"];
    mobile = json["mobile"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["email"] = email;
    map["mobile"] = mobile;
    map["token"] = token;
    return map;
  }
}
