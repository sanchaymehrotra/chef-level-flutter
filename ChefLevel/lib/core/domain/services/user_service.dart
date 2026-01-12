import 'package:dio/dio.dart';
import 'package:food_chef/core/domain/network/dio_client.dart';
import 'package:food_chef/core/utils/constant/environment/end_points.dart';

class UserService {
  UserService({required this.dioClient});

  DioClient dioClient;

  Future<Response?> checkUser(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);

      final response = await dioClient.post(
        baseUrl + EndPoints.check_profile_exist,
        data,

        options,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load departments: $e');
    }
  }

  Future<Response?> createAccount(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);

      final response = await dioClient.post(
        baseUrl + EndPoints.create_account,
        data,

        options,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load departments: $e');
    }
  }

  Future<Response?> login(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);

      final response = await dioClient.post(
        baseUrl + EndPoints.login,
        data,

        options,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load departments: $e');
    }
  }

  Future<Response?> verifyOtp(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);

      final response = await dioClient.post(
        baseUrl + EndPoints.verify_otp,
        data,

        options,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load departments: $e');
    }
  }

  Future<Response?> dataDefination(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);

      final response = await dioClient.post(
        cmsBaseUrl + EndPoints.data_defination,
        data,
        options,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load departments: $e');
    }
  }

  Future<Response?> savePrefLevel(
    String jsonBodyData,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);

      final response = await dioClient.post(
        baseUrl + EndPoints.save_prefs_data,
        jsonBodyData,
        options,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to load departments: $e');
    }
  }
}
