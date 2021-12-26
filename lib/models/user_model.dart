/// id : 1
/// name : "Shumi Mala"
/// phone : "9841231230"
/// email : "shumi@blue.com"
/// license : "sajkndaj"
/// license_photo : "https://logistics.intopros.com.np/images\\uploads\\1637780990WhatsApp Image 2021-11-17 at 8.46.26 AM (1).png"
/// experience : "2"
/// photo : "https://logistics.intopros.com.np/images\\uploads\\1637780990WhatsApp Image 2021-11-17 at 8.46.26 AM (1).png"

class UserModel {
  UserModel({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? license,
    String? licensePhoto,
    String? experience,
    String? photo,
  }) {
    _id = id;
    _name = name;
    _phone = phone;
    _email = email;
    _license = license;
    _licensePhoto = licensePhoto;
    _experience = experience;
    _photo = photo;
  }

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _license = json['license'];
    _licensePhoto = json['license_photo'];
    _experience = json['experience'];
    _photo = json['photo'];
  }
  int? _id;
  String? _name;
  String? _phone;
  String? _email;
  String? _license;
  String? _licensePhoto;
  String? _experience;
  String? _photo;

  int? get id => _id;
  String? get name => _name;
  String? get phone => _phone;
  String? get email => _email;
  String? get license => _license;
  String? get licensePhoto => _licensePhoto;
  String? get experience => _experience;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['email'] = _email;
    map['license'] = _license;
    map['license_photo'] = _licensePhoto;
    map['experience'] = _experience;
    map['photo'] = _photo;
    return map;
  }
}
