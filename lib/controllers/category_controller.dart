import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_getx/models/product_category.dart';
import 'package:shop_getx/repositories/category_repository.dart';

class CategoryController extends GetxController {
  final CategoryRepository _categoryRepository = CategoryRepository();

  TextEditingController categoryName = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() {
    _categoryRepository.getCategories().then((value) {
      categoryList = value;
      update();
    });
  }

  void addCategory(ProductCategory category) {
    _categoryRepository.addCategory(newCategory: category);
    categoryList.add(category);
    update();
  }

  void deleteCategory(ProductCategory category){
    _categoryRepository.deleteCategory(targetCategory: category);
    categoryList.remove(category);
    update();
  }

  void editCategory(ProductCategory category, int categoryIndex){
    _categoryRepository.editCategory(targetCategory: category);
    categoryList[categoryIndex] = category;
    update();
  }


}

List<ProductCategory> categoryList = [];
