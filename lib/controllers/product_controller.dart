
import 'package:get/get.dart';

import '../models/product.dart';

class ProductController extends GetxController {

  RxBool test = true.obs;
  RxList<Product> productList = RxList<Product>();

  RxInt productCount  = 0.obs;
  addProduct(Product product) {
    product.productCount = product.productCount! + 1;
  }

  void removeProduct(Product product) {
    product.productCount = product.productCount! - 1;
  }

  @override
  void onInit() {
    super.onInit();
    productList = [
      Product(
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
    ].obs;
  }

}
