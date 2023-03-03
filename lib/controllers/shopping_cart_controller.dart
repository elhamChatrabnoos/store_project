import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shop_getx/models/shopping_cart.dart';
import 'package:shop_getx/repositories/shopping_cart_repository.dart';

class ShoppingCartController extends GetxController {
  final ShoppingCartRepository _shoppingCartRepository =
      ShoppingCartRepository();

  void addCart(ShoppingCart cart) {
    _shoppingCartRepository
        .addShoppingCart(newCart: cart)
        .then((value) => print('add cart success!'));
  }

  void editCart() {

  }

}
