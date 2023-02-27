import 'package:get/get.dart';

import '../models/product.dart';

class ProductController extends GetxController {

  addProductToBasket(Product product) {
    product.productCount += 1;
    int indexOfProduct = buyBasketList.indexOf(product);

    // when product is in the buy basket just change its count number
    // else add product to add basket list
    if (indexOfProduct > -1) {
      buyBasketList[indexOfProduct].productCount =
          buyBasketList[indexOfProduct].productCount + 1;
    }
    else {
      buyBasketList.add(product);
    }
    update();
  }

  void removeProductFromBasket(Product product) {
    product.productCount = product.productCount - 1;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}

List<Product> productList = [
  Product(
      productCount: 0,
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      shortProductDescrip: '300 گرم',
      longProductDescrip: 'دارای وزن 300 گرم'
          ' کشور سازنده آلمان '
          'دارای رایحه لوندر'
          'مناسب برای لباسشویی',
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),
  Product(
      productCount: 0,
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      shortProductDescrip: '300 گرم',
      productDiscount: 5,
      longProductDescrip: 'دارای وزن 300 گرم'
          ' کشور سازنده آلمان '
          'دارای رایحه لوندر'
          'مناسب برای لباسشویی',
      productPrice: 30000,
      isAvailable: true),
  Product(
      productCount: 0,
      productImage: 'assets/images/powder.png',
      productName: 'تاید لباسشویی',
      shortProductDescrip: '300 گرم',
      longProductDescrip: 'دارای وزن 300 گرم'
          ' کشور سازنده آلمان '
          'دارای رایحه لوندر'
          'مناسب برای لباسشویی',
      productDiscount: 5,
      productPrice: 30000,
      isAvailable: true),
];

List<Product> buyBasketList = [];
