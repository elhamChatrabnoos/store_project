import 'package:shop_getx/models/shopping_cart.dart';
import 'package:shop_getx/repositories/dio_field.dart';

import '../models/user.dart';

class ShoppingCartRepository{

  Future<ShoppingCart> addShoppingCart({required ShoppingCart newCart}) async{
    try{
      var response = await dioBaseUrl.post('shoppingCart', data: newCart.toJson());
      ShoppingCart retrievedCart = ShoppingCart.fromJson(response.data);
      return retrievedCart;
    }
    catch(e){
      print('add shopping cart errorrrrr: ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<List<ShoppingCart>> getShoppingCarts() async{
    var response = await dioBaseUrl.get('shoppingCart');
    try {
      final shoppingCartResult = await response.data.map<ShoppingCart>((element) {
        return ShoppingCart.fromJson(element);
      }).toList();
      return shoppingCartResult;
    } catch (e) {
      print('****get shoppingCart error*****: ${e.toString()}');
      return throw e.toString();
    }
  }


  Future<ShoppingCart> editShoppingCart({required User targetShoppingCart, required num shoppingCartId}) async{
    try{
      var response = await dioBaseUrl.put('shoppingCart/${shoppingCartId.toString()}', data: targetShoppingCart.toJson());
      ShoppingCart retrievedCart = ShoppingCart.fromJson(response.data);
      return retrievedCart;
    }
    catch(e){
      print('***edit ShoppingCart error*** ${e.toString()}');
      return throw e.toString();
    }
  }


}