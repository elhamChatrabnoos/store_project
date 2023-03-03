import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/repositories/dio_field.dart';

class ProductRepository {
  // Future<Either<String, List<Product>>> getProducts() async {
  //   var productsList = await dioBaseUrl.get('product');
  //   try {
  //     final result =
  //         productsList.data.map<Product>((e) => Product.fromJson(e)).toList();
  //     return Right(result);
  //   } catch (e) {
  //     return Left('left part ${e.toString()}');
  //   }
  // }

  Future<Product> updateProduct(
      {required Product targetProduct, required String productId}) async {
    try {
      var response =
          await dioBaseUrl.put('product', data: targetProduct.toJson());
      Product? updatedProduct = Product.fromJson(response.data);
      return updatedProduct;
    } catch (e) {
      print('error of update product: ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<List<Product>> getProducts() async {
    var productsList = await dioBaseUrl.get('product');
    try {
      final productResult = await productsList.data.map<Product>((element) {
        print('every thing ok');
        return Product.fromJson(element);
      }).toList();
      return productResult;
    } catch (e) {
      return throw e.toString();
    }
  }
}
