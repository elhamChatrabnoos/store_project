class Product {
  String? productImage;
  String? productName;
  String? productDescription;
  int? productDiscount;
  int? productPrice;
  bool? isAvailable;

  Product({
    this.productImage,
    this.productName,
    this.productDescription,
    this.productDiscount,
    this.productPrice,
    this.isAvailable,
  });

}

List<Product> productList = [

  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      productDescription: 'وزن محصول',
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),

  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      productDescription: 'وزن محصول',
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),

  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      productDescription: 'وزن محصول',
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),

  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      productDescription: 'وزن محصول',
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),

  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      productDescription: 'وزن محصول',
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true)
];
