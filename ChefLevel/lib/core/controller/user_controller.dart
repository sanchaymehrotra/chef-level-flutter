import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/user/check_profile_model.dart';
import 'package:food_chef/core/domain/models/preference_level/get_all_pref_data_model.dart';
import 'package:food_chef/core/domain/models/preference_level/get_saved_pref_data_model.dart';
import 'package:food_chef/core/domain/repository/user_repository.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  final userRepository = getIt.get<UserRepository>();

  Future<DataModel> checkUserProfileExist(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString(SharedPrefService.deviceId);
    final deviceType = prefs.getString(SharedPrefService.deviceType);
    final sessionId = prefs.getString(SharedPrefService.sessionId);
    final identifier = prefs.getString(SharedPrefService.mmReqIdentifier);

    final Map<String, dynamic> headersData = {
      'deviceId': deviceId,
      'deviceType': deviceType,
      'sessionId': sessionId,
      'channel': 'APP',
      'mmReqIdentifier': identifier,
    };

    return userRepository.checkUser(data, headersData);
  }

  Future<DataModel> createAccount(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString(SharedPrefService.deviceId);
    final deviceType = prefs.getString(SharedPrefService.deviceType);
    final sessionId = prefs.getString(SharedPrefService.sessionId);
    final identifier = prefs.getString(SharedPrefService.mmReqIdentifier);

    final Map<String, dynamic> headersData = {
      'deviceId': deviceId,
      'deviceType': deviceType,
      'sessionId': sessionId,
      'channel': 'APP',
      'mmReqIdentifier': identifier,
    };

    return userRepository.createAccount(data, headersData);
  }

  Future<DataModel> login(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString(SharedPrefService.deviceId);
    final deviceType = prefs.getString(SharedPrefService.deviceType);
    final sessionId = prefs.getString(SharedPrefService.sessionId);
    final identifier = prefs.getString(SharedPrefService.mmReqIdentifier);
    final uid = prefs.getString(SharedPrefService.uid);

    final Map<String, dynamic> headersData = {
      'deviceId': deviceId,
      'deviceType': deviceType,
      'sessionId': sessionId,
      'channel': 'APP',
      'mmReqIdentifier': identifier,
      'uid': uid,
    };

    return userRepository.login(data, headersData);
  }

  Future<DataModel> verifyOtp(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString(SharedPrefService.deviceId);
    final deviceType = prefs.getString(SharedPrefService.deviceType);
    final sessionId = prefs.getString(SharedPrefService.sessionId);
    final identifier = prefs.getString(SharedPrefService.mmReqIdentifier);
    final uid = prefs.getString(SharedPrefService.uid);

    final Map<String, dynamic> headersData = {
      'deviceId': deviceId,
      'deviceType': deviceType,
      'sessionId': sessionId,
      'channel': 'APP',
      'mmReqIdentifier': identifier,
      'uid': uid,
    };

    return userRepository.verifyOtp(data, headersData);
  }

  Future<PrefDataModel?> dataDefination(Map<String, dynamic> data) async {
    final Map<String, dynamic> headersData = {};

    final dataResponse = userRepository.dataDefination(data, headersData);
    return dataResponse;
  }

  Future<GetPrefSavedData> savePrefLevelData(String jsonBodyData) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(SharedPrefService.uid);
    final Map<String, dynamic> headersData = {'uid': uid};
    return userRepository.savePrefLevel(jsonBodyData, headersData);
  }
}

//CU1767636564849---- +966 8287560855
