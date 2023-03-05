import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shop_getx/controllers/user_controller.dart';
import 'package:shop_getx/models/shopping_cart.dart';
import 'package:shop_getx/repositories/shopping_cart_repository.dart';

import '../models/product.dart';

class ShoppingCartController extends GetxController {
  List<ShoppingCart> shoppingCartList = [];
  final ShoppingCartRepository _shoppingCartRepository =
      ShoppingCartRepository();
  UserController userController = UserController();
  Product? targetProduct;

  @override
  void onInit() {
    super.onInit();
    getShoppingCarts();
  }

  void getShoppingCarts() {
    _shoppingCartRepository.getShoppingCarts().then((value) {
      shoppingCartList = value;
      for (var cart in shoppingCartList) {
        if (cart.userId == userController.getUserFromPref()['id']) {
          buyBasketList = cart.shoppingList!;
        }
      }
    });
  }

  void addCart(ShoppingCart cart) {
    _shoppingCartRepository.addShoppingCart(newCart: cart).then((value) {
      print('add cart success!');
    });
  }

  void editCart(ShoppingCart cart) {
    _shoppingCartRepository.editShoppingCart(
        targetShoppingCart: cart, shoppingCartId: cart.id!);
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

    editBasketList(buyBasketList);
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

  void editBasketList(List<Product> buyBasketList) {
    for (var cart in shoppingCartList) {
      if (cart.userId == userController.getUserFromPref()['id']) {
        cart.shoppingList = buyBasketList;
      }
    }
  }
}
