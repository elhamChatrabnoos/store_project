import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_getx/repositories/product_repository.dart';

import '../models/product.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController totalCountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() {
    _productRepository.getProducts().then((value) {
      productList = value;
      update();
    });
  }

  Future<Product> addProduct(Product product) async {
    Product newProduct = Product();
    await _productRepository.addProduct(newProduct: product).then((value) {
      newProduct = value;
      getProducts();
    });
    update();
    return newProduct;
  }

  void editProduct(Product product) {
    _productRepository
        .editProduct(targetProduct: product)
        .then((value) => getProducts());
    update();
  }

  void deleteProduct(Product product) {
    _productRepository
        .deleteProduct(targetProduct: product)
        .then((value) => getProducts());
    update();
  }
}

List<Product> productList = [];
