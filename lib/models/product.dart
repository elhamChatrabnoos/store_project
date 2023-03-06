class Product {
  Product({
    this.id,
    this.productName,
    this.productImage,
    this.productDescription,
    this.productDiscount,
    this.productPrice,
    this.isAvailable,
    this.productCategory,
    this.productCountInBasket,
    this.totalProductCount,
  });

  Product.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    productDescription = json['productDescription'];
    productDiscount = json['productDiscount'];
    productPrice = json['productPrice'];
    isAvailable = json['isAvailable'];
    productCategory = json['productCategory'];
    productCountInBasket = json['productCountInBasket'];
    totalProductCount = json['totalProductCount'];
  }

  num? id;
  String? productName;
  String? productImage;
  String? productDescription;
  num? productDiscount;
  num? productPrice;
  bool? isAvailable;
  String? productCategory;
  num? productCountInBasket;
  num? totalProductCount;

  Product copyWith({
    num? id,
    String? productName,
    String? productImage,
    String? productDescription,
    num? productDiscount,
    num? productPrice,
    bool? isAvailable,
    String? productCategory,
    num? productCountInBasket,
    num? totalProductCount,
  }) =>
      Product(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        productImage: productImage ?? this.productImage,
        productDescription: productDescription ?? this.productDescription,
        productDiscount: productDiscount ?? this.productDiscount,
        productPrice: productPrice ?? this.productPrice,
        isAvailable: isAvailable ?? this.isAvailable,
        productCategory: productCategory ?? this.productCategory,
        productCountInBasket: productCountInBasket ?? this.productCountInBasket,
        totalProductCount: totalProductCount ?? this.totalProductCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productDescription'] = productDescription;
    map['productDiscount'] = productDiscount;
    map['productPrice'] = productPrice;
    map['isAvailable'] = isAvailable;
    map['productCategory'] = productCategory;
    map['productCountInBasket'] = productCountInBasket;
    map['totalProductCount'] = totalProductCount;
    return map;
  }
}
