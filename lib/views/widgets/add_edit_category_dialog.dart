

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/models/product_category.dart';

import '../../controllers/profile_image_controller.dart';
import '../../core/app_colors.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';
import 'profile_image.dart';

class AddEditCategoryDialog extends GetView<ProfileImageController>{
  AddEditCategoryDialog({this.categoryIndex,this.targetCategory, required this.isActionEdit, Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  CategoryController catController = Get.find<CategoryController>();
  final bool isActionEdit;
  final ProductCategory? targetCategory;
  final int? categoryIndex;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileImageController());

    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _categoryImage(context),
            AppSizes.normalSizeBox3,
            _textField(),
            AppSizes.normalSizeBox3,
            _saveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _categoryImage(BuildContext context) {
    return GetBuilder<ProfileImageController>(
      assignId: true,
      builder: (logic) {
        return ProfileImageShape(
          tapOnGallery: () {
            logic.selectProfileImage(false);
            Navigator.pop(context);
          },
          tapOnCamera: () {
            logic.selectProfileImage(true);
            Navigator.pop(context);
          },
          tapOnDelete: () {
            logic.removeProfileImage();
            Navigator.pop(context);
          },
          imageFile: logic.profileImage,
        );
      },
    );
  }

  Widget _textField() {
    return CustomTextField(
      controller: catController.categoryName,
      checkValidation: (value) {
        if (value!.isEmpty) {
          return 'نام دسته بندی نمیتواند خالی باشد.';
        }
      },
      labelText: 'نام دسته بندی',
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _saveButton(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      buttonText: isActionEdit ? 'ویرایش' : 'ذخیره',
      buttonColor: AppColors.loginBtnColor,
      onTap: () {
        if (formKey.currentState!.validate()) {
          !isActionEdit ? _addCategory() : _editCategory();
          Get.back();
        }
      },
      textSize: AppSizes.normalTextSize2,
    );
  }

  void _addCategory(){
    ProductCategory category = ProductCategory(
        name: catController.categoryName.text,
        image: "",
        productsList: []);
    catController.addCategory(category);
  }

  void _editCategory(){
    ProductCategory category = ProductCategory(
        id: targetCategory!.id,
        name: catController.categoryName.text,
        image:  "controller.profileImage",
        productsList: targetCategory!.productsList);

    catController.editCategory(category, categoryIndex!);
  }



}
