import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/domain/models/home/tailored_recipes_list_model.dart';

class ItemDetailsProvider extends ChangeNotifier {
  final int _pageSize = 1;
  int _currentPage = 0;
  bool _isFavoriteTailoredAll = false;

  List<TailoredRecipe>? _tailoredRecipeHomeList = [];
  
  // See all Tailored recipies, master chef, Popular Technique recipies
  List<TailoredAllRecipiesResult>? _tailoredRecipiesAllList = [];
  List<TailoredAllRecipiesResult>? _tailoredRecipiesFilteredAllList = [];
  
  bool _isLastPage = false;

  // Get Home Data List
  List<TailoredRecipe>? get tailoredRecipesHomeData => _tailoredRecipeHomeList;
  
  // See all Get Tailored recipies, Master Chef, Popular Technique recipies
  List<TailoredAllRecipiesResult>? get tailoredRecipiesFilteredAllData =>
      _tailoredRecipiesFilteredAllList;
  
  bool get isFavoriteTailoredAll => _isFavoriteTailoredAll;
  
  bool get isLastPage => _isLastPage;
  int get currentPage => _currentPage;
  int get pageSize => _pageSize;


  void setTailoredAllRecipiesData(TailoredRecipesAllData? data) {
    _tailoredRecipiesAllList = data?.results ?? [];
    _tailoredRecipiesFilteredAllList!.addAll(_tailoredRecipiesAllList!);
    _isLastPage = data!.last ?? false;
    notifyListeners();
  }


  void setIsFavoriteTailoredAll(bool isClicked) {
    _isFavoriteTailoredAll = isClicked;
    notifyListeners();
  }


  void loadMoreData() {
    _currentPage++;
    notifyListeners();
  }

  // Clear the See All data

  void clearAllData() {
    _tailoredRecipiesAllList!.clear();
    _tailoredRecipiesFilteredAllList!.clear();
    _currentPage = 0;
    _isLastPage = false;
    notifyListeners();
  }
}
