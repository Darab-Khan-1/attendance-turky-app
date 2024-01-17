import 'dart:ffi';

class LoginModel {
  int? statusCode;
  String? message;
  String? error;
  Data? data;
  bool? isLogin ;

  LoginModel({this.statusCode, this.message, this.error, this.data, this.isLogin});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    isLogin = json['status_code'] == 200 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    // data['isLogin'] = this.data?.bearerToken;
    data['isLogin'] = isLogin;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? bearerToken;
  String? uniqueId;
  bool? onlinestatus;
  Data({this.bearerToken, this.uniqueId, this.onlinestatus});

  Data.fromJson(Map<String, dynamic> json) {
    bearerToken = json['bearer_token'];
    uniqueId = json['unique_id'];
    onlinestatus = json['online'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bearer_token'] = bearerToken;
    data['unique_id'] = uniqueId;
    data['online'] = onlinestatus;
    return data;
  }
}
