import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_line_field_package/multi_line_field_package.dart';
import 'package:shop_getx/controllers/admin/category_controller.dart';
import 'package:shop_getx/controllers/admin/radio_button_controller.dart';
import 'package:shop_getx/controllers/admin/tag_controller.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/models/product_category.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

import '../../controllers/shared/image_controller.dart';
import '../../controllers/shared/product_controller.dart';
import '../../core/app_colors.dart';
import '../../models/Tag.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/image_picker.dart';

class AddEditProductPage extends StatefulWidget {
  const AddEditProductPage({required this.category, this.product, Key? key})
      : super(key: key);

  final ProductCategory category;
  final Product? product;

  @override
  State<AddEditProductPage> createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  final formKey = GlobalKey<FormState>();

  TagController tagController = Get.put(TagController());
  ProductController productController = Get.find<ProductController>();
  CategoryController cateController = Get.find<CategoryController>();
  ImageController controller = Get.put(ImageController());
  RadioBtnController radioController = Get.put(RadioBtnController());

  @override
  void initState() {
    super.initState();
    _initialControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(LocaleKeys.Add_product_page_title.tr),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: _bodyOfPage(context));
  }

  Padding _bodyOfPage(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 10),
        child: Form(
          key: formKey,
          // Todo delete thumb and show keyboard and textField together
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _productImage(context),
              AppSizes.normalSizeBox3,
              _productName(LocaleKeys.Add_product_page_productName.tr, false),
              AppSizes.normalSizeBox3,
              _productDescription(
                  LocaleKeys.Add_product_page_productDescription.tr),
              AppSizes.normalSizeBox3,
              _productPrice(LocaleKeys.Add_product_page_productPrice.tr),
              AppSizes.normalSizeBox3,
              _productDiscount(LocaleKeys.Add_product_page_productDiscount.tr),
              AppSizes.normalSizeBox3,
              _productTotalCount(
                  LocaleKeys.Add_product_page_totalProductCount.tr),
              AppSizes.normalSizeBox3,
              _productTag(context, LocaleKeys.Add_product_page_productTag.tr),
              AppSizes.normalSizeBox3,
              _isProductHide(),
              _saveButton(context),
            ],
          )),
        ));
  }

  Widget _productImage(BuildContext context) {
    return GetBuilder<ImageController>(
      assignId: true,
      builder: (logic) {
        return ImagePicker(
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
          imageFile: controller.imageFile != null
              ? controller.stringToImage(controller.imageFile)
              : null,
        );
      },
    );
  }

  Widget _saveButton(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      buttonText: LocaleKeys.Dialogs_message_saveBtn.tr,
      buttonColor: AppColors.loginBtnColor,
      onTap: () {
        if (formKey.currentState!.validate()) {
          _addOrEditProductInList();
        }
      },
      buttonHeight: 50,
      buttonWidth: MediaQuery.of(context).size.width,
      textSize: AppSizes.normalTextSize2,
    );
  }

  void _addOrEditProductInList() {
    if (controller.imageFile == null) {
      Get.snackbar(LocaleKeys.Add_product_page_imageWarning.tr,
          LocaleKeys.Add_product_page_addImageMsg.tr);
    } else {
      bool isProductHide = _checkProductHideOrNot();
      String? tagName = tagController.tag!.name;
      Product newProduct;
      if (widget.product == null) {
        newProduct = _createNewProduct(isProductHide, tagName);
        _addProduct(newProduct);
      }
      // edit product in category list
      else {
        newProduct = _setProductFeature(isProductHide, tagName);
        _editProductInLists(newProduct);
      }
    }
  }

  void _editProductInLists(Product newProduct) {
    productController.editProduct(newProduct).then((value) {
      for (var i = 0; i < widget.category.productsList!.length; ++i) {
        if (widget.category.productsList![i].id == widget.product!.id) {
          widget.category.productsList![i] = newProduct;
          break;
        }
      }
      cateController.editCategory(widget.category).then((value) {
        Get.back();
      });
    });
  }

  Product _setProductFeature(bool isProductHide, String? tagName) {
    return Product(
      id: widget.product!.id,
      productImage: controller.imageFile,
      productName: productController.nameController.text,
      productDescription: productController.descriptionController.text,
      productPrice: int.parse(productController.priceController.text),
      productDiscount: productController.discountController.text != null
          ? int.parse(productController.discountController.text)
          : 0,
      isProductHide: isProductHide,
      productCategory: widget.category.name,
      productCountInBasket: 0,
      totalProductCount: int.parse(productController.totalCountController.text),
      productTag: tagName,
    );
  }

  bool _checkProductHideOrNot() {
    bool isProductHide =
        radioController.radioGroupValue == LocaleKeys.Dialogs_message_yesBtn.tr
            ? true
            : false;
    return isProductHide;
  }

  Future<Null> _addProduct(Product newProduct) {
    return productController.addProduct(newProduct).then((value) {
      widget.category.productsList!.add(value);
      cateController.editCategory(widget.category).then((value) {
        Get.back();
      });
    });
  }

  Product _createNewProduct(bool isProductHide, String? tagName) {
    return Product(
      productImage: controller.imageFile,
      productName: productController.nameController.text,
      productDescription: productController.descriptionController.text,
      productPrice: int.parse(productController.priceController.text),
      productDiscount: productController.discountController.text != null
          ? int.parse(productController.discountController.text)
          : 0,
      isProductHide: isProductHide,
      productCategory: widget.category.name,
      productCountInBasket: 0,
      totalProductCount: int.parse(productController.totalCountController.text),
      productTag: tagName,
    );
  }

  Widget _productName(String text, bool isNumberField) {
    return CustomTextField(
      controller: productController.nameController,
      checkValidation: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.Add_product_page_addProductError.tr;
        }
      },
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productDescription(String text) {
    return MultiLineField(
      controller: productController.descriptionController,
      validation: (value) {
        if (value!.isEmpty && value.length < 6) {
          return LocaleKeys.Add_product_page_addProductError.tr;
        }
      },
      maxLines: 5,
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productPrice(String text) {
    return CustomTextField(
      controller: productController.priceController,
      checkValidation: (value) {
        if (value!.isEmpty ||
            int.parse(value) < 1000 ||
            int.parse(value) > 100000000) {
          return LocaleKeys.Add_product_page_addProductError.tr;
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productDiscount(String text) {
    return CustomTextField(
      controller: productController.discountController,
      checkValidation: (value) {
        if (value!.isEmpty || int.parse(value) > 100) {
          return LocaleKeys.Add_product_page_addProductError.tr;
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productTotalCount(String text) {
    return CustomTextField(
      controller: productController.totalCountController,
      checkValidation: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.Add_product_page_addProductError.tr;
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productTag(BuildContext context, String text) {
    return Container(
        color: AppColors.backGroundColor,
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<TagController>(
          assignId: true,
          builder: (logic) {
            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<Tag>(
                    hint: Text(text),
                    // if any term click to edit disable this button
                    onChanged: (value) {
                      logic.changeDropDown(value!);
                    },
                    value: logic.tag,
                    items: tagsList.map((Tag item) {
                      return DropdownMenuItem<Tag>(
                          value: item, child: Text(item.name!));
                    }).toList(),
                  )),
            );
          },
        ));



  }

  Widget _isProductHide() {
    return GetBuilder<RadioBtnController>(
      assignId: true,
      builder: (logic) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text: LocaleKeys.Add_product_page_isProductHide.tr),
            _radioButton(LocaleKeys.Add_product_page_yesBtn.tr),
            _radioButton(LocaleKeys.Add_product_page_noBtn.tr),
          ],
        );
      },
    );
  }

  Widget _radioButton(String text) {
    return Expanded(
        child: RadioListTile(
      activeColor: AppColors.primaryColor,
      title: Text(text),
      value: text,
      groupValue: radioController.radioGroupValue,
      onChanged: (value) {
        radioController.changeRadioValue(value.toString());
      },
    ));
  }

  void _initialControllers() {
    tagController.getTags().then((value) {
      if (widget.product != null) {
        tagController.tag!.name = widget.product!.productTag;
      }
    });

    if (widget.product != null) {
      productController.nameController.text = widget.product!.productName!;
      productController.descriptionController.text =
          widget.product!.productDescription!;
      productController.priceController.text =
          widget.product!.productPrice.toString();
      productController.discountController.text =
          widget.product!.productDiscount.toString();
      productController.totalCountController.text =
          widget.product!.totalProductCount.toString();

      radioController.radioGroupValue = widget.product!.isProductHide!
          ? LocaleKeys.Add_product_page_yesBtn.tr
          : LocaleKeys.Add_product_page_noBtn.tr;

      controller.imageFile = widget.product!.productImage;
    } else {
      productController.nameController.text = '';
      productController.descriptionController.text = '';
      productController.priceController.text = '';
      productController.discountController.text = '';
      productController.totalCountController.text = '';
    }
  }
}
