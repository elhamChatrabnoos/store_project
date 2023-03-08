import 'package:shop_getx/repositories/dio_field.dart';

import '../models/product_category.dart';


class CategoryRepository {

  Future<ProductCategory> addCategory({required ProductCategory newCategory}) async {
    try {
      var response =
          await dioBaseUrl.post('productCategory', data: newCategory.toJson());
      ProductCategory retrievedCategory = ProductCategory.fromJson(response.data);
      return retrievedCategory;
    } catch (e) {
      print('add category errorrrrr: ${e.toString()}');
      return throw e.toString();
    }
  }


  Future<List<ProductCategory>> getCategories() async {
    var response = await dioBaseUrl.get('productCategory');
    try {
      final categoryResult = await response.data.map<ProductCategory>((element) {
        return ProductCategory.fromJson(element);
      }).toList();
      return categoryResult;
    } catch (e) {
      print('****get category error*****: ${e.toString()}');
      return throw e.toString();
    }
  }


  Future<ProductCategory> editCategory(
      {required ProductCategory targetCategory}) async {
    try {
      var response = await dioBaseUrl.put('productCategory/${targetCategory.id.toString()}',
          data: targetCategory.toJson());
      ProductCategory retrievedCategory = ProductCategory.fromJson(response.data);
      return retrievedCategory;
    } catch (e) {
      print('***edit category error*** ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<ProductCategory> deleteCategory(
      {required ProductCategory targetCategory}) async {
    try {
      var response = await dioBaseUrl.delete('productCategory/${targetCategory.id.toString()}',
          data: targetCategory.toJson());
      ProductCategory retrievedCategory = ProductCategory.fromJson(response.data);
      return retrievedCategory;
    } catch (e) {
      print('***delete category error*** ${e.toString()}');
      return throw e.toString();
    }
  }


}
