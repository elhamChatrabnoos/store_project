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

List<Product> productList = [
  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      shortProductDescrip: '300 گرم',
      longProductDescrip: 'دارای وزن 300 گرم'
          ' کشور سازنده آلمان '
      'دارای رایحه لوندر'
      'مناسب برای لباسشویی'
      ,
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),
  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      shortProductDescrip: '300 گرم',
      productDiscount: 5,
      longProductDescrip: 'دارای وزن 300 گرم'
          ' کشور سازنده آلمان '
          'دارای رایحه لوندر'
          'مناسب برای لباسشویی'
      ,
      productPrice: 30000,
      isAvailable: true),
  Product(
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      shortProductDescrip: '300 گرم',
      longProductDescrip: 'دارای وزن 300 گرم'
          ' کشور سازنده آلمان '
          'دارای رایحه لوندر'
          'مناسب برای لباسشویی'
      ,
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),
  // Product(
  //     productImage: 'assets/images/powder.png',
  //     productName: 'تاید لباسشویی',
  //     shortProductDescrip: '300 گرم',
  //     productDiscount: 5,
  //     productPrice: 30000,
  //     isAvailable: true),
  // Product(
  //     productImage: 'assets/images/powder.png',
  //     productName: 'تاید لباسشویی',
  //     shortProductDescrip: '300 گرم',
  //     productDiscount: 5,
  //     productPrice: 30000,
  //     isAvailable: true)
];
