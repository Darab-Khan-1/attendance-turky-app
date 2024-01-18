class AllAttendanceModel {
  int? statusCode;
  String? message;
  String? error;
  List<Data>? data;

  AllAttendanceModel({this.statusCode, this.message, this.error, this.data});

  AllAttendanceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? checkIn;
  String? checkOut;
  String? hours;
  String? createdAt;

  Data({this.checkIn, this.checkOut, this.hours, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    hours = json['hours'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['hours'] = this.hours;
    data['created_at'] = this.createdAt;
    return data;
  }
}
