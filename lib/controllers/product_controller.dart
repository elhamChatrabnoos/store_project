import 'package:get/get.dart';
import 'package:shop_getx/repositories/product_repository.dart';

import '../models/product.dart';

class ProductController extends GetxController {

  final ProductRepository _productRepository = ProductRepository();

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts(){
    _productRepository.getProducts().then((value){
      productList = value;
    });
  }

  void editProduct(Product product) {
    _productRepository
        .editProduct(targetProduct: product)
        .then((value) {
      product = value;
      print('success update');
      update();
    });
  }

}

List<Product> productList = [];
