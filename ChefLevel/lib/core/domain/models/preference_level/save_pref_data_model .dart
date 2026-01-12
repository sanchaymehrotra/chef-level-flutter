// ignore_for_file: file_names

class PrefSaveDataModel {
  final List<String>? dietaryPreferences;
  final List<String>? favouriteCuisines;
  final String? spiceLevelPreference;

  PrefSaveDataModel({
    this.dietaryPreferences,
    this.favouriteCuisines,
    this.spiceLevelPreference,
  });

  factory PrefSaveDataModel.fromJson(Map<String, dynamic> json) {
    return PrefSaveDataModel(
      dietaryPreferences: json['dietaryPreferences'] != null ? List<String>.from(json['dietaryPreferences']) : null,
      favouriteCuisines: json['favouriteCuisines'] != null ? List<String>.from(json['favouriteCuisines']) : null,
      spiceLevelPreference: json['spiceLevelPreference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dietaryPreferences': dietaryPreferences,
      'favouriteCuisines': favouriteCuisines,
      'spiceLevelPreference': spiceLevelPreference,
    };
  }
}
