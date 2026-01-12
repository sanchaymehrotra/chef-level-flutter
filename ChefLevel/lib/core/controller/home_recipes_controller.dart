import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/home/chef_list_model.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/domain/models/home/popular_technique_list_model.dart';
import 'package:food_chef/core/domain/models/home/tailored_recipes_list_model.dart';
import 'package:food_chef/core/domain/repository/home_recipes_repository.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRecipesController {
  final homeRecipesRepository = getIt.get<HomeRecipesRepository>();

  Future<HomeRecipesDataModel> getHomeData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(SharedPrefService.uid);
    final Map<String, dynamic> headersData = {'uid': uid};
    return homeRecipesRepository.getHomeRecipesData(data, headersData);
  }

  Future<ChefListDataModel> getChefList(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(SharedPrefService.uid);
    final Map<String, dynamic> headersData = {'uid': uid};
    return homeRecipesRepository.getChefListData(data, headersData);
  }

  Future<TailoredRecipeListDataModel> getTailoerdRecipeList(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(SharedPrefService.uid);
    final Map<String, dynamic> headersData = {'uid': uid};
    return homeRecipesRepository.getTailoerdRecipeListData(data, headersData);
  }

  Future<PopularTechniquesListDataModel> getPopularTechniqueList(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(SharedPrefService.uid);
    final Map<String, dynamic> headersData = {'uid': uid};
    return homeRecipesRepository.getPopularTechniqueListData(data, headersData);
  }
}
