import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/models/product_category.dart';

import '../../controllers/image_controller.dart';
import '../../core/app_colors.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';
import 'image_picker.dart';

class AddEditCategoryDialog extends GetView<ImageController> {
  AddEditCategoryDialog(
      {this.targetCategory, required this.isActionEdit, Key? key})
      : super(key: key);

  final bool isActionEdit;
  final ProductCategory? targetCategory;

  final formKey = GlobalKey<FormState>();

  // CategoryController controller = Get.find<CategoryController>();
  CategoryController cateController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());

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
          )),
    );
  }

  Widget _categoryImage(BuildContext context) {
    return GetBuilder<ImageController>(
      initState: (state) {
        if (targetCategory != null) {
          controller.imageFile = targetCategory!.image;
        }
      },
      assignId: true,
      builder: (controller) {
        return ImagePicker(
          tapOnGallery: () {
            controller.selectProfileImage(false);
            Navigator.pop(context);
          },
          tapOnCamera: () {
            controller.selectProfileImage(true);
            Navigator.pop(context);
          },
          tapOnDelete: () {
            controller.removeProfileImage();
            Navigator.pop(context);
          },
          imageFile: controller.imageFile != null
              ? controller.stringToImage(controller.imageFile)
              : null,
        );
      },
    );
  }

  Widget _textField() {
    return CustomTextField(
      controller: cateController.categoryName,
      checkValidation: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.HomePage_categoryNameError.tr;
        }
      },
      labelText: LocaleKeys.HomePage_categoryName.tr,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _saveButton(BuildContext context) {
    return CustomButton(
      buttonWidth: 100,
      buttonHeight: 40,
      textColor: Colors.white,
      buttonText: isActionEdit
          ? LocaleKeys.Dialogs_message_editBtn.tr
          : LocaleKeys.Dialogs_message_saveBtn.tr,
      buttonColor: AppColors.loginBtnColor,
      onTap: () {
        if (formKey.currentState!.validate() && controller.imageFile != null) {
          !isActionEdit ? _addCategory() : _editCategory();
          Get.back();
        } else {
          Get.snackbar(LocaleKeys.HomePage_notCompleteFieldWarning.tr,
              LocaleKeys.HomePage_completeCategoryInfo.tr);
        }
      },
      textSize: AppSizes.normalTextSize2,
    );
  }

  void _addCategory() {
    ProductCategory category = ProductCategory(
        name: cateController.categoryName.text,
        image: controller.imageFile!,
        productsList: []);
    cateController.addCategory(category);
  }

  void _editCategory() {
    ProductCategory category = ProductCategory(
        id: targetCategory!.id,
        name: cateController.categoryName.text,
        image: controller.imageFile,
        productsList: targetCategory!.productsList);

    cateController.editCategory(category);
  }
}
