import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/repositories/dio_field.dart';

class ProductRepository {

  Future<List<Product>> getProducts() async {
    var productsList = await dioBaseUrl.get('product');
    try {
      final productResult = await productsList.data.map<Product>((element) {
        return Product.fromJson(element);
      }).toList();
      return productResult;
    } catch (e) {
      return throw e.toString();
    }
  }


  Future<Product> addProduct({required Product newProduct}) async{
    try{
      var response = await dioBaseUrl.post('product', data: newProduct.toJson());
      Product retrievedProduct = Product.fromJson(response.data);
      return retrievedProduct;
    }
    catch(e){
      print('add product errorrrrr: ${e.toString()}');
      return throw e.toString();
    }
  }


  Future<Product> editProduct(
      {required Product targetProduct, required num productId}) async {
    try {
      var response =
      await dioBaseUrl.put('product/${productId.toString()}', data: targetProduct.toJson());
      Product? updatedProduct = Product.fromJson(response.data);
      return updatedProduct;
    } catch (e) {
      print('error of update product: ${e.toString()}');
      return throw e.toString();
    }
  }

}
