class DriverStatus {
  int? statusCode;
  String? message;
  String? error;
  Data? data;

  DriverStatus({this.statusCode, this.message, this.error, this.data});

  DriverStatus.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? online;
  String? checkIn;
  String? checkOut;

  Data({this.online, this.checkIn, this.checkOut});

  Data.fromJson(Map<String, dynamic> json) {
    online = json['online'];
    checkIn = json['check_in'] == null ? '' : json['check_in'];
    checkOut = json['check_out'] == null ? '' : json['check_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['online'] = this.online;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    return data;
  }
}
