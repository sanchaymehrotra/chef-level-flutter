import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/models/home/chef_list_model.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/domain/models/home/popular_technique_list_model.dart';
import 'package:food_chef/core/domain/models/home/tailored_recipes_list_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  final int _pageSize = 1;
  int _currentPage = 0;
  bool _isFavoriteHome = false;
  bool _isFavoriteTailoredAll = false;
  bool _isFavoriteMasterChefAll = false;
  bool _isFavoritePopularTechniqueAll = false;

  // Home Data List
  List<TailoredRecipe>? _tailoredRecipeHomeList = [];
  List<Chef>? _chefHomeList = [];
  List<PopularTechnique>? _popularRecipeHomeList = [];

  // See all Tailored recipies, master chef, Popular Technique recipies
  List<TailoredAllRecipiesResult>? _tailoredRecipiesAllList = [];
  List<TailoredAllRecipiesResult>? _tailoredRecipiesFilteredAllList = [];
  List<ChefAllResult>? _masterChefAllList = [];
  List<ChefAllResult>? _masterChefFilteredAllList = [];
  List<PopuarTechniqueAllResult>? _popularTechniqueAllList = [];
  List<PopuarTechniqueAllResult>? _popularTechniqueFilteredAllList = [];

  bool _isLastPage = false;

  // Get Home Data List
  List<TailoredRecipe>? get tailoredRecipesHomeData => _tailoredRecipeHomeList;
  List<Chef>? get masterChefHomeData => _chefHomeList;
  List<PopularTechnique>? get popularTechniquesHomeData =>
      _popularRecipeHomeList;

  // See all Get Tailored recipies, Master Chef, Popular Technique recipies
  List<TailoredAllRecipiesResult>? get tailoredRecipiesFilteredAllData =>
      _tailoredRecipiesFilteredAllList;
  List<ChefAllResult>? get masterChefFilteredAllData =>
      _masterChefFilteredAllList;
  List<PopuarTechniqueAllResult>? get popularTechniqueFilteredAllData =>
      _popularTechniqueFilteredAllList;

  bool get isFavoriteHome => _isFavoriteHome;
  bool get isFavoriteTailoredAll => _isFavoriteTailoredAll;
  bool get isFavoriteMasterChefAll => _isFavoriteMasterChefAll;
  bool get isFavoritePopularTechniqueAll => _isFavoritePopularTechniqueAll;

  bool get isLastPage => _isLastPage;
  int get currentPage => _currentPage;
  int get pageSize => _pageSize;

  void setHomeRecipesData(HomeData? data) {
    _tailoredRecipeHomeList = data?.tailoredRecipes ?? [];
    _chefHomeList = data?.chefs ?? [];
    _popularRecipeHomeList = data?.popularTechniques ?? [];
    notifyListeners();
  }

  void setTailoredAllRecipiesData(TailoredRecipesAllData? data) {
    _tailoredRecipiesAllList = data?.results ?? [];
    _tailoredRecipiesFilteredAllList!.addAll(_tailoredRecipiesAllList!);
    _isLastPage = data!.last ?? false;
    notifyListeners();
  }

  void setMasterChefAllData(ChefAllData? data) {
    _masterChefAllList = data?.results ?? [];
    _masterChefFilteredAllList!.addAll(_masterChefAllList!);
    _isLastPage = data!.last ?? false;
    notifyListeners();
  }

  void setPopularTechniqueAllData(PopuarTechniqueAllData? data) {
    _popularTechniqueAllList = data?.results ?? [];
    _popularTechniqueFilteredAllList!.addAll(_popularTechniqueAllList!);
    _isLastPage = data!.last ?? false;
    notifyListeners();
  }

  void setIsFavoriteTailoredHome(bool isClicked) {
    _isFavoriteHome = isClicked;
    notifyListeners();
  }

  void setIsFavoriteTailoredAll(bool isClicked) {
    _isFavoriteTailoredAll = isClicked;
    notifyListeners();
  }

  void setIsFavoriteMasterChefdAll(bool isClicked) {
    _isFavoriteMasterChefAll = isClicked;
    notifyListeners();
  }

  void setIsFavoritePopularTechniqueAll(bool isClicked) {
    _isFavoritePopularTechniqueAll = isClicked;
    notifyListeners();
  }

  void loadMoreData() {
    _currentPage++;
    notifyListeners();
  }

  // Clear the See All data

  void clearSeeAllData() {
    _masterChefAllList!.clear();
    _masterChefFilteredAllList!.clear();
    _tailoredRecipiesAllList!.clear();
    _tailoredRecipiesFilteredAllList!.clear();
    _popularTechniqueAllList!.clear();
    _popularTechniqueFilteredAllList!.clear();
    _currentPage = 0;
    _isLastPage = false;
    notifyListeners();
  }
}
