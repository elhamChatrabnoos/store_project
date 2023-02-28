import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_getx/models/product.dart';

class ProductRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/',
      // baseUrl: 'http://10.0.2. 2:3000/',
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
