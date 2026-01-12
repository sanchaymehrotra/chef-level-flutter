import 'package:dio/dio.dart';
import 'package:food_chef/core/domain/models/user/check_profile_model.dart';
import 'package:food_chef/core/domain/models/preference_level/get_all_pref_data_model.dart';
import 'package:food_chef/core/domain/models/preference_level/get_saved_pref_data_model.dart';
import 'package:food_chef/core/domain/network/api_exception.dart';
import 'package:food_chef/core/domain/services/user_service.dart';

class UserRepository {
  UserRepository(this.userService);

  final UserService userService;

  Future<DataModel> checkUser(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await userService.checkUser(data, headersData);
      DataModel res = DataModel.fromJson(response?.data);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa1');
      print(res);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa2');

      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<DataModel> createAccount(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await userService.createAccount(data, headersData);
      DataModel res = DataModel.fromJson(response?.data);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa1');
      print(res);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa2');

      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<DataModel> login(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await userService.login(data, headersData);
      DataModel res = DataModel.fromJson(response?.data);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa1');
      print(res);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa2');

      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<DataModel> verifyOtp(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await userService.verifyOtp(data, headersData);
      DataModel res = DataModel.fromJson(response?.data);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa1');
      print(res);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa2');

      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<PrefDataModel?> dataDefination(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await userService.dataDefination(data, headersData);

      return PrefDataModel.fromJson(response?.data);
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<GetPrefSavedData> savePrefLevel(
    String jsonBodyData,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await userService.savePrefLevel(jsonBodyData, headersData);
      GetPrefSavedData res = GetPrefSavedData.fromJson(response?.data);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa1');
      print(res);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa2');
      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  // Future<List<BinItemDetails>> getBinItemDetails(

  //     String storeId, String binLocation, String userId) async {

  //   try {

  //     final response = await binInquiryService.getBinItemDetails(

  //         storeId, binLocation, userId);

  //     List<dynamic> jsonList = response?.data['results'];

  //       List<BinItemDetails> departmentResponse =

  //           jsonList.map((json) => BinItemDetails.fromJson(json)).toList();

  //       return departmentResponse;

  //     } on DioException catch (e) {

  //     throw APIException.fromDioError(e).toString();

  //   }

  // }
}
