import 'package:get/get.dart';
import 'package:shop_getx/repositories/product_repository.dart';

import '../models/product.dart';

class ProductController extends GetxController {

  final ProductRepository _productRepository = ProductRepository();
  RxBool isLoading = true.obs;
  Product? targetProduct;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts(){
    isLoading = true.obs;
    _productRepository.getProducts().then((value){
      productList = value;
      isLoading = false.obs;
    });
    // update();
  }

  // Future<void> getProducts() async {
  //   final resultOrError = await _productRepository.getProducts();
  //   resultOrError.fold((left) {
  //     print('left ${left}');
  //   }, (List<Product> receivedProductList) {
  //     productList = receivedProductList.obs;
  //   });
  //   update();
  // }


  void updateProduct(Product product) {
    _productRepository
        .updateProduct(targetProduct: product, productId: product.productId!)
        .then((value) {
      product = value;
      print('success update');
      update();
    });
  }


  addProductToBasket(Product product) {
    // when product is in the buy basket just change its count number
    // else add product to add basket list
    int indexOfProduct = buyBasketList.indexOf(product);
    if (indexOfProduct > -1) {
      buyBasketList[indexOfProduct].productCountInBasket =
          buyBasketList[indexOfProduct].productCountInBasket! + 1;
    } else {
      product.productCountInBasket = 1;
      buyBasketList.add(product);
    }
    update();
  }

  void removeProductFromBasket(Product product) {
    product.productCountInBasket = product.productCountInBasket! - 1;
    if (product.productCountInBasket! < 1) {
      buyBasketList.remove(product);
    }
    update();
  }


  bool searchProductInBasket(Product product) {
    for (var i = 0; i < buyBasketList.length; ++i) {
      if (product.productId == buyBasketList[i].productId) {
        targetProduct = buyBasketList[i];
        return true;
      }
    }
    return false;
  }

}

List<Product> productList = [];

List<Product> buyBasketList = [];
