import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shop_getx/models/product.dart';

class ProductRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/',
      // baseUrl: 'http://192.168.1.123/',
      // baseUrl: 'http://22.198.147.172:3000/',
      receiveDataWhenStatusError: true,
      // connectTimeout: const Duration(seconds: 5),
    ),
  );

  Future<Either<String, List<Product>>> getProducts() async {
    var productsList = await _dio.get('product');
    try {
      final result =
          productsList.data.map<Product>((e) => Product.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left('left part ${e.toString()}');
    }
  }

  Future<Product> updateProduct(
      {required Product targetProduct, required String productId}) async {
    try {
      var response = await _dio.put('product', data: targetProduct.toJson());
      Product? updatedProduct = Product.fromJson(response.data);
      return updatedProduct;
    } catch (e) {
      print('error of update product: ${e.toString()}');
      return throw e.toString();
    }
  }

// Future<List<Product>> getProducts() async {
//   var productsList = await _dio.get('product');
//   try {
//     final productResult = await productsList.data.map<Product>((element) {
//       print('every thing ok');
//       return Product.fromJson(element);
//     }).toList();
//     return productResult;
//   } catch (e) {
//     return throw e.toString();
//   }
// }
}
