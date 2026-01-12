import 'package:dio/dio.dart';
import 'package:food_chef/core/domain/network/dio_client.dart';
import 'package:food_chef/core/utils/constant/environment/end_points.dart';

class HomeRecipesService {
  HomeRecipesService({required this.dioClient});
  DioClient dioClient;
  Future<Response?> getHomeRecipes(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);
      final response = await dioClient.post(
        baseUrl + EndPoints.get_home_recipes_data,
        data,
        options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
  Future<Response?> getChefList(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);
      final response = await dioClient.post(
        baseUrl + EndPoints.get_chef_list,
        data,
        options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
  Future<Response?> getTailoredRecipeList(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);
      final response = await dioClient.post(
        baseUrl + EndPoints.get_tailored_recipe_list,
        data,
        options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
  Future<Response?> getPopularTechniqueList(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      var options = Options(headers: headersData);
      final response = await dioClient.post(
        baseUrl + EndPoints.get_popular_technique_list,
        data,
        options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

}
