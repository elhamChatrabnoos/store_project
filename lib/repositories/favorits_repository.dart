import 'package:shop_getx/models/favorites.dart';
import 'package:shop_getx/repositories/dio_field.dart';

class FavoritesRepository {

  Future<Favorite> addFavorite({required Favorite newFavorite}) async {
    try {
      var response = await dioBaseUrl.post('favorites', data: newFavorite.toJson());
      Favorite retrievedFavorite = Favorite.fromJson(response.data);
      return retrievedFavorite;
    } catch (e) {
      print('add favorite errorrrrr: ${e.toString()}');
      return throw e.toString();
    }
  }


  Future<List<Favorite>> getFavorites() async {
    var response = await dioBaseUrl.get('favorites');
    try {
      final favoriteResult = await response.data.map<Favorite>((element) {
        return Favorite.fromJson(element);
      }).toList();
      return favoriteResult;
    } catch (e) {
      print('****get favorite error*****: ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<Favorite> editFavoriteList(
      {required Favorite targetFavorite}) async {
    try {
      var response = await dioBaseUrl.put(
          'favorites/${targetFavorite.id.toString()}',
          data: targetFavorite.toJson());
      Favorite retrievedFavorite = Favorite.fromJson(response.data);
      return retrievedFavorite;
    } catch (e) {
      print('***edit Favorite error*** ${e.toString()}');
      return throw e.toString();
    }
  }


}
