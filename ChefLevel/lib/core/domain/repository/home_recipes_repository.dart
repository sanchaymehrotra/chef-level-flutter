import 'package:dio/dio.dart';
import 'package:food_chef/core/domain/models/home/chef_list_model.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/domain/models/home/popular_technique_list_model.dart';
import 'package:food_chef/core/domain/models/home/tailored_recipes_list_model.dart';
import 'package:food_chef/core/domain/network/api_exception.dart';
import 'package:food_chef/core/domain/services/home_recipes_service.dart';

class HomeRecipesRepository {
  HomeRecipesRepository(this.homeRecipesService);

  final HomeRecipesService homeRecipesService;

  Future<HomeRecipesDataModel> getHomeRecipesData(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await homeRecipesService.getHomeRecipes(
        data,
        headersData,
      );
      HomeRecipesDataModel res = HomeRecipesDataModel.fromJson(response?.data);
      print(res);
      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<ChefListDataModel> getChefListData(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await homeRecipesService.getChefList(
        data,
        headersData,
      );
      ChefListDataModel res = ChefListDataModel.fromJson(response?.data);
      print(res);
      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<TailoredRecipeListDataModel> getTailoerdRecipeListData(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await homeRecipesService.getTailoredRecipeList(
        data,
        headersData,
      );
      TailoredRecipeListDataModel res = TailoredRecipeListDataModel.fromJson(response?.data);
      print(res);
      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }

  Future<PopularTechniquesListDataModel> getPopularTechniqueListData(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await homeRecipesService.getPopularTechniqueList(
        data,
        headersData,
      );
      PopularTechniquesListDataModel res = PopularTechniquesListDataModel.fromJson(response?.data);
      print(res);
      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }


}
