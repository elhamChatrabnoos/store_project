class Product {
  String? productImage;
  String? productName;
  String? shortProductDescrip;
  String? longProductDescrip;
  int? productDiscount;
  int? productPrice;
  bool? isAvailable;
  String? productCategory;
  String? productSubCategory;
  int? productCount = 0;

  Product({
    this.productImage,
    this.productName,
    this.shortProductDescrip,
    this.longProductDescrip,
    this.productDiscount,
    this.productPrice,
    this.isAvailable,
  });
}

