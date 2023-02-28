import 'package:get/get.dart';
import 'package:shop_getx/repositories/product_repository.dart';

import '../models/product.dart';

class ProductController extends GetxController {

  final ProductRepository _productRepository = ProductRepository();
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  // void getProducts(){
  //   isLoading = true.obs;
  //   print('toye khoroji mobile vared *then* nemishe');
  //   _productRepository.getProducts().then((value){
  //     productList = value.obs;
  //     print('isLoading before change $isLoading');
  //     isLoading = false.obs;
  //     print('isLoading $isLoading');
  //   });
  //   print('toye khoroji web in ejra *nemishe $isLoading');
  //   // update();
  // }

  Future<void> getProducts() async {
    final resultOrError = await _productRepository.getProducts();
    resultOrError.fold((left) {
      print('left ${left}');
    }, (List<Product> receivedProductList) {
      productList = receivedProductList.obs;
    });
    update();
  }


  addProductToBasket(Product product) {
    // when product is in the buy basket just change its count number
    // else add product to add basket list
    int indexOfProduct = buyBasketList.indexOf(product);
    if (indexOfProduct > -1) {
      buyBasketList[indexOfProduct].productCountInBasket =
          buyBasketList[indexOfProduct].productCountInBasket! + 1;
    }
    else {
      product.productCountInBasket = 1;
      buyBasketList.add(product);
    }
    update();
  }

  void removeProductFromBasket(Product product) {
    product.productCountInBasket = product.productCountInBasket! - 1;
    update();
  }

}

List<Product> productList = [];

List<Product> buyBasketList = [];
