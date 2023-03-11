class Product {
  Product({
    this.id,
    this.productName,
    this.productDescription,
    this.productImage,
    this.productTag,
    this.productDiscount,
    this.productPrice,
    this.isProductHide,
    this.productCategory,
    this.productCountInBasket,
    this.totalProductCount,
  });

  Product.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productImage = json['productImage'];
    productTag = json['productTag'];
    productDiscount = json['productDiscount'];
    productPrice = json['productPrice'];
    isProductHide = json['isAvailable'];
    productCategory = json['productCategory'];
    productCountInBasket = json['productCountInBasket'];
    totalProductCount = json['totalProductCount'];
  }

  num? id;
  String? productName;
  String? productDescription;
  String? productImage;
  String? productTag;
  num? productDiscount;
  num? productPrice;
  bool? isProductHide;
  String? productCategory;
  num? productCountInBasket;
  num? totalProductCount;

  Product copyWith({
    num? id,
    String? productName,
    String? productDescription,
    String? productImage,
    String? productTag,
    num? productDiscount,
    num? productPrice,
    bool? isProductHide,
    String? productCategory,
    num? productCountInBasket,
    num? totalProductCount,
  }) =>
      Product(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        productDescription: productDescription ?? this.productDescription,
        productImage: productImage ?? this.productImage,
        productTag: productTag ?? this.productTag,
        productDiscount: productDiscount ?? this.productDiscount,
        productPrice: productPrice ?? this.productPrice,
        isProductHide: isProductHide ?? this.isProductHide,
        productCategory: productCategory ?? this.productCategory,
        productCountInBasket: productCountInBasket ?? this.productCountInBasket,
        totalProductCount: totalProductCount ?? this.totalProductCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productDescription'] = productDescription;
    map['productImage'] = productImage;
    map['productTag'] = productTag;
    map['productDiscount'] = productDiscount;
    map['productPrice'] = productPrice;
    map['isAvailable'] = isProductHide;
    map['productCategory'] = productCategory;
    map['productCountInBasket'] = productCountInBasket;
    map['totalProductCount'] = totalProductCount;
    return map;
  }
}
