import 'package:shop_getx/models/product.dart';

class ProductCategory {

  ProductCategory({
    this.id,
    this.image,
    this.name,
    this.productsList,
  });

  ProductCategory.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    if (json['productsList'] != null) {
      productsList = [];
      json['productsList'].forEach((v) {
        productsList?.add(Product.fromJson(v));
      });
    }
  }

  num? id;
  String? image;
  String? name;
  List<Product>? productsList;

  ProductCategory copyWith({
    num? id,
    String? image,
    String? name,
    List<Product>? productsList,
  }) =>
      ProductCategory(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        productsList: productsList ?? this.productsList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    if (productsList != null) {
      map['productsList'] = productsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }


}
