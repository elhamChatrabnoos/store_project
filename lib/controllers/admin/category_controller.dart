import 'package:flutter/cupertino.dart';
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
    _categoryRepository.addCategory(newCategory: category).then((value) {
      getCategories();
    });
    update();
  }

  void deleteCategory(ProductCategory category) {
    _categoryRepository.deleteCategory(targetCategory: category).then((value) {
      categoryList.remove(category);
      update();
      // getCategories();
    });

  }

  Future<void> editCategory(ProductCategory category) async {
    await _categoryRepository
        .editCategory(targetCategory: category)
        .then((value) {
      print('update category');
      getCategories();
    });
    update();
  }
}

List<ProductCategory> categoryList = [];
