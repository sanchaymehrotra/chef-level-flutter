class Data {
  final String? check;
  final dynamic uid;

  Data({
    this.check,
    this.uid,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      check: json['check'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'check': check,
      'uid': uid,
    };
  }
}

class DataModel {
  final Data? data;
  final String? message;
  final int? responseCode;
  final String? status;

  DataModel({
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      responseCode: json['responseCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'responseCode': responseCode,
      'status': status,
    };
  }
}