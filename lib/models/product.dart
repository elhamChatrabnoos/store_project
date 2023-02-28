class Product {
  Product({
    this.productId,
    this.productName,
    this.productImage,
    this.productDescription,
    this.productDiscount,
    this.productPrice,
    this.isAvailable,
    this.productCategory,
    this.productSubCategory,
    this.productCountInBasket,
    this.totalProductCount,
  });

  Product.fromJson(dynamic json) {
    productId = json['productId'];
    productName = json['productName'];
    productImage = json['productImage'];
    productDescription = json['productDescription'];
    productDiscount = json['productDiscount'];
    productPrice = json['productPrice'];
    isAvailable = json['isAvailable'];
    productCategory = json['productCategory'];
    productSubCategory = json['productSubCategory'];
    productCountInBasket = json['productCountInBasket'];
    totalProductCount = json['totalProductCount'];
  }

  String? productId;
  String? productName;
  String? productImage;
  String? productDescription;
  num? productDiscount;
  num? productPrice;
  bool? isAvailable;
  String? productCategory;
  String? productSubCategory;
  num? productCountInBasket;
  num? totalProductCount;

  Product copyWith({
    String? productId,
    String? productName,
    String? productImage,
    String? productDescription,
    num? productDiscount,
    num? productPrice,
    bool? isAvailable,
    String? productCategory,
    String? productSubCategory,
    num? productCountInBasket,
    num? totalProductCount,
  }) =>
      Product(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productImage: productImage ?? this.productImage,
        productDescription: productDescription ?? this.productDescription,
        productDiscount: productDiscount ?? this.productDiscount,
        productPrice: productPrice ?? this.productPrice,
        isAvailable: isAvailable ?? this.isAvailable,
        productCategory: productCategory ?? this.productCategory,
        productSubCategory: productSubCategory ?? this.productSubCategory,
        productCountInBasket: productCountInBasket ?? this.productCountInBasket,
        totalProductCount: totalProductCount ?? this.totalProductCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productDescription'] = productDescription;
    map['productDiscount'] = productDiscount;
    map['productPrice'] = productPrice;
    map['isAvailable'] = isAvailable;
    map['productCategory'] = productCategory;
    map['productSubCategory'] = productSubCategory;
    map['productCountInBasket'] = productCountInBasket;
    map['totalProductCount'] = totalProductCount;
    return map;
  }
}
