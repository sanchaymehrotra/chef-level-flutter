class GetPrefSavedDataModel {
  final List<String>? dietaryPreferences;
  final List<String>? favouriteCuisines;
  final String? spiceLevelPreference;
  final String? uid;

  GetPrefSavedDataModel({
    this.dietaryPreferences,
    this.favouriteCuisines,
    this.spiceLevelPreference,
    this.uid,
  });

  factory GetPrefSavedDataModel.fromJson(Map<String, dynamic> json) {
    return GetPrefSavedDataModel(
      dietaryPreferences: json['dietaryPreferences'] != null
          ? List<String>.from(json['dietaryPreferences'])
          : null,
      favouriteCuisines: json['favouriteCuisines'] != null
          ? List<String>.from(json['favouriteCuisines'])
          : null,
      spiceLevelPreference: json['spiceLevelPreference'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dietaryPreferences': dietaryPreferences,
      'favouriteCuisines': favouriteCuisines,
      'spiceLevelPreference': spiceLevelPreference,
      'uid': uid,
    };
  }
}

class GetPrefSavedData {
  final GetPrefSavedDataModel? data;
  final String? message;
  final int? responseCode;
  final String? status;

  GetPrefSavedData({this.data, this.message, this.responseCode, this.status});

  factory GetPrefSavedData.fromJson(Map<String, dynamic> json) {
    return GetPrefSavedData(
      data: json['data'] != null
          ? GetPrefSavedDataModel.fromJson(json['data'])
          : null,
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
