import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/controllers/user_controller.dart';
import 'package:shop_getx/models/favorites.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/repositories/favorits_repository.dart';

import '../core/app_keys.dart';
import '../shared_class/shared_prefrences.dart';

class FavoritesController extends GetxController {
  RxBool isFavorite = false.obs;

  List<Favorite> allFavoriteList = [];
  final FavoritesRepository _favoritesRepository = FavoritesRepository();

  @override
  void onInit() {
    super.onInit();
    defineSharedPref();
    getFavorites();
  }

  Future<void> defineSharedPref() async {
    AppSharedPreference.favoritePref = await SharedPreferences.getInstance();
  }

  void changeFavoriteIcon() {
    isFavorite.value = isFavorite.value ? false : true;
  }

  bool searchItemInFavorites(Product product) {
    if (favoritesList.any((element) => element.id == product.id)) {
      return true;
    }
    return false;
  }

  Future<void> editFavoriteList(Product product) async {
    // search product in favorite list
    bool isProductInList = false;
    Product? favoriteProduct;
    for (var element in favoritesList) {
      if (element.id == product.id) {
        isProductInList = true;
        favoriteProduct = element;
      }
    }

    // change favorite position
    if (isProductInList) {
      favoritesList.remove(favoriteProduct);
    } else {
      favoritesList.add(product);
    }

    // edit favorite list
    num userId = UserController.getUserFromPref()['userId'];
    print('id of favor : ' +
        AppSharedPreference.favoritePref!.getInt(AppKeys.favorId).toString());
    Favorite favorite = Favorite(
        id: AppSharedPreference.favoritePref!.getInt(AppKeys.favorId),
        userId: userId,
        favoritesList: favoritesList);

    await _favoritesRepository
        .editFavoriteList(targetFavorite: favorite)
        .then((value) {
      getFavorites();
    });
    update();
  }

  void addFavorite(Favorite newFavorite) {
    _favoritesRepository.addFavorite(newFavorite: newFavorite).then((value) {
      AppSharedPreference.favoritePref!.setInt(AppKeys.favorId, value.id!);
    });
  }

  void getFavorites() {
    _favoritesRepository.getFavorites().then((value) {
      allFavoriteList = value;
      update();
      // searchUserInFavorites(UserController.getUserFromPref()['userId']);
    });
  }

  bool searchUserInFavorites(num userId) {
    for (var favorite in allFavoriteList) {
      if (favorite.userId == userId) {
        favoritesList = favorite.favoritesList!;
        AppSharedPreference.favoritePref!.setInt(AppKeys.favorId, favorite.id!);
        return true;
      }
    }
    return false;
  }
}
