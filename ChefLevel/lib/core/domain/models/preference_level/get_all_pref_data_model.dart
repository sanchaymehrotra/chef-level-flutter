class Data {
  final int? id;
  final String? key;
  final String? value;

  Data({
    this.id,
    this.key,
    this.value,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'value': value,
    };
  }
}

class PrefDataModel {
  final List<Data>? data;
  final String? message;
  final int? responseCode;
  final String? status;

  PrefDataModel({
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });

  factory PrefDataModel.fromJson(Map<String, dynamic> json) {
    return PrefDataModel(
      data: json['data'] != null ? List<Data>.from(json['data'].map((x) => Data.fromJson(x))) : null,
      message: json['message'],
      responseCode: json['responseCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((x) => x.toJson()).toList(),
      'message': message,
      'responseCode': responseCode,
      'status': status,
    };
  }
}