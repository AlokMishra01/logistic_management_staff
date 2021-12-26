/// phone : "The phone must be 10 digits."
/// password : "The password field is required."

class ValidationErrorModel {
  Validation_errors({
    String? phone,
    String? password,
  }) {
    _phone = phone;
    _password = password;
  }

  ValidationErrorModel.fromJson(dynamic json) {
    _phone = json['phone'];
    _password = json['password'];
  }
  String? _phone;
  String? _password;

  String? get phone => _phone;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['password'] = _password;
    return map;
  }
}
