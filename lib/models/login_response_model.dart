import 'user_model.dart';
import 'validation_error_model.dart';

/// status : false
/// status_code : 422
/// validation_errors : {"phone":"The phone must be 10 digits.","password":"The password field is required."}
/// message : "The phone must be 10 digits., The password field is required."
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDIxYTQwY2ZhZTg5NzQ3MDAxOWZiZTZjOTdmOTdmNDUyN2U5ZWQ1MmIyY2QxZDJiNzhlZDIzZGYwNTlmNGMxM2E5MWZkZjdjMWZjYzk0YzEiLCJpYXQiOjE2Mzk2Njk2OTMsIm5iZiI6MTYzOTY2OTY5MywiZXhwIjoxNjcxMjA1NjkzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Z3FUOM7dzPJAR5iikrevOrZOCt_6bJIhs5-DT0-kXueWotpqvZtD4QGXfD_IOzYJiH0hSyg3c7nyEBTTZaXAlgNusG3vDbp2I1T-yxoNhpSpWiPJ9WKDF8l47NrjatoVh8GUzKMIqsWTqCm09oFl5TMKJiHnw48jaU3klv2fDodlKEMjbs8avksSifg5uUX-dPjNWrst5p6UtXxnAzT52BVlH5crYgIQy66b599JZj6Ix9395Bb2ftMhHl8KNzts2dHhLgvxEhKMnb_oHyf3IORr85W-MMJs87X6qxYF2wzhLOPNbRealvaJccMR_OVy5K5gQBx3OGGcQ0P9IYR9ZNZlUiTfYq3QDjt3wdbaexUAceQqjqg7UkkPoJXCT_ejZ4uAJzbJ2ygqrbcjIapEYBxIPqJIX8g4_WcSR_BnD1SITw70FqbTgWo1Elnw0ceJSPSDwt3an3B7pa2qfKynjBj_fwtX0T1nWKuMyrQvqwKYnNcfYIt4xFDJM8QtU3twNO5Erp7Bg_-UZgZYWQ8MGxl4nQxQOwyfMTgRflwM98s5C5qvpa4Xuqc3lmOhzrhZjZEEWmBsRd5ZivPtj9NT2o5b9wS2blS-XpJm_CANNJX3CIaljxvtkyoFKthYjVFDBXK72xEoKhyG4X5nJK6VHumqUew82PcdSk96ROHdPDM"
/// data : {"id":1,"name":"Shumi Mala","phone":"9841231230","email":"shumi@blue.com","license":"sajkndaj","license_photo":"https://logistics.intopros.com.np/images\\uploads\\1637780990WhatsApp Image 2021-11-17 at 8.46.26 AM (1).png","experience":"2","photo":"https://logistics.intopros.com.np/images\\uploads\\1637780990WhatsApp Image 2021-11-17 at 8.46.26 AM (1).png"}

class LoginResponseModel {
  LoginResponseModel({
    bool? status,
    int? statusCode,
    ValidationErrorModel? validationErrors,
    String? message,
    String? token,
    UserModel? user,
  }) {
    _status = status;
    _statusCode = statusCode;
    _validationErrors = validationErrors;
    _message = message;
    _token = token;
    _user = user;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _validationErrors = json['validation_errors'] != null
        ? ValidationErrorModel.fromJson(json['validationErrors'])
        : null;
    _message = json['message'];
    _token = json['token'];
    _user = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }
  bool? _status;
  int? _statusCode;
  ValidationErrorModel? _validationErrors;
  String? _message;
  String? _token;
  UserModel? _user;

  bool? get status => _status;
  int? get statusCode => _statusCode;
  ValidationErrorModel? get validationErrors => _validationErrors;
  String? get message => _message;
  String? get token => _token;
  UserModel? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['status_code'] = _statusCode;
    if (_validationErrors != null) {
      map['validation_errors'] = _validationErrors?.toJson();
    }
    map['message'] = _message;
    map['token'] = _token;
    if (_user != null) {
      map['data'] = _user?.toJson();
    }
    return map;
  }
}
