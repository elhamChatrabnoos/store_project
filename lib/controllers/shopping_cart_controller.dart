import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/controllers/user_controller.dart';
import 'package:shop_getx/models/shopping_cart.dart';
import 'package:shop_getx/repositories/shopping_cart_repository.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';

import '../core/app_keys.dart';
import '../models/product.dart';

class ShoppingCartController extends GetxController {
  List<ShoppingCart> shoppingCartList = [];
  final ShoppingCartRepository _shoppingCartRepository =
      ShoppingCartRepository();
  Product? targetProduct;

  @override
  void onInit() {
    super.onInit();
    defineSharedPref();
    getShoppingCarts();
  }

  void getShoppingCarts() {
    _shoppingCartRepository.getShoppingCarts().then((value) {
      shoppingCartList = value;
      searchUserShoppingCart(UserController.getUserFromPref()['userId']);
    });
  }

  void addShoppingCart(ShoppingCart cart) {
    _shoppingCartRepository.addShoppingCart(newCart: cart).then((value) {
      AppSharedPreference.shoppingCartPref!
          .setInt(AppKeys.cartShoppingId, value.id!);
    });
  }

  void editShoppingCart(Product product) {
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

    _editCartInServer();
    update();
  }

  void _editCartInServer() {
    num userId = UserController.getUserFromPref()['userId'];
    ShoppingCart editedCart = ShoppingCart(
        id: AppSharedPreference.shoppingCartPref!
            .getInt(AppKeys.cartShoppingId),
        userId: userId,
        shoppingList: buyBasketList);

    _shoppingCartRepository.editShoppingCart(targetShoppingCart: editedCart).then((value){
      getShoppingCarts();
    });

  }

  bool searchUserShoppingCart(num userId) {
    for (var cart in shoppingCartList) {
      if (cart.userId == userId) {
        buyBasketList = cart.shoppingList!;
        AppSharedPreference.shoppingCartPref!
            .setInt(AppKeys.cartShoppingId, cart.id!);
        return true;
      }
    }
    return false;
  }

  void removeProductFromBasket(Product product) {
    product.productCountInBasket = product.productCountInBasket! - 1;
    if (product.productCountInBasket! < 1) {
      buyBasketList.remove(product);
    }
    _editCartInServer();
    update();
  }

  bool searchProductInBasket(Product product) {
    for (var i = 0; i < buyBasketList.length; ++i) {
      if (product.id == buyBasketList[i].id) {
        targetProduct = buyBasketList[i];
        return true;
      }
    }
    return false;
  }

  double totalShoppingCart() {
    double total = 0;
    for (var element in buyBasketList) {
      if (element.productDiscount! > 0) {
        total += (element.productPrice! -
                element.productPrice! * element.productDiscount! ~/ 100) *
            element.productCountInBasket!;
      } else {
        total += element.productPrice! * element.productCountInBasket!;
      }
    }
    update();
    return total;
  }

  bool allProductStock() {
    for (var cartProduct in buyBasketList) {
      for (var product in productList) {
        if (cartProduct.id == product.id) {
          if (!(cartProduct.productCountInBasket! <=
              product.totalProductCount!)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  void emptyShoppingCart() {
    buyBasketList.clear();
    _editCartInServer();
    update();
  }

  Future<void> defineSharedPref() async {
    AppSharedPreference.shoppingCartPref =
        await SharedPreferences.getInstance();
  }
}
