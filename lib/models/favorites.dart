import 'package:shop_getx/models/product.dart';

class Favorite {
  Favorite({
    this.id,
    this.userId,
    this.favoritesList,
  });

  Favorite.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    if (json['favoritesProduct'] != null) {
      favoritesList = [];
      json['favoritesProduct'].forEach((v) {
        favoritesList?.add(Product.fromJson(v));
      });
    }
  }

  int? id;
  num? userId;
  List<Product>? favoritesList;

  Favorite copyWith({
    int? id,
    num? userId,
    List<Product>? favoritesProduct,
  }) =>
      Favorite(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        favoritesList: favoritesProduct ?? this.favoritesList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    if (favoritesList != null) {
      map['favoritesProduct'] =
          favoritesList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

List<Product> favoritesList = [];
