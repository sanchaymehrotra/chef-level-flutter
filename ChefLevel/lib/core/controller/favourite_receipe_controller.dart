import 'package:get/get.dart';

class FavouriteReceipeController extends GetxController {
  RxMap<int, bool> favorites = <int, bool>{}.obs;

  void toggleFavorite(int id) {
    favorites[id] = !(favorites[id] ?? false);
  }

  bool isFavorite(int id) {
    return favorites[id] ?? false;
  }

}
