import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/controllers/shopping_cart_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/models/product_category.dart';
import 'package:shop_getx/views/widgets/custom_button.dart';
import 'package:shop_getx/views/widgets/custom_dialog.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/shopping_cart.dart';
import '../../widgets/product_item.dart';

class ShoppingCartPage extends GetView {
  ShoppingCartPage({Key? key}) : super(key: key);

  final ProductController productController = Get.find<ProductController>();
  // final CategoryController cateController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShoppingCartController());
    Get.lazyPut(() => CategoryController());
    return GetBuilder<ShoppingCartController>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppColors.grayColor,
          body: buyBasketList.isNotEmpty
              ? _bodyItems(logic)
              : Center(
            child: CustomText(
                text: 'سبد خرید شما خالی است',
                textSize: AppSizes.normalTextSize1,
                textColor: Colors.black),
          ),
        );
      },
    );
  }

  Widget _bodyItems(ShoppingCartController controller) {
    return Column(
      children: [
        _completeShopping(controller),
        AppSizes.littleSizeBox,
        _shoppingCartList(controller)
      ],
    );
  }

  Widget _shoppingCartList(ShoppingCartController shoppingController) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: buyBasketList.length,
        itemBuilder: (context, index) {
          return ProductItem(
            iconLike: false,
            isFade: false,
            onAddBtnClick: () {
              shoppingController.editShoppingCart(buyBasketList[index]);
            },
            onRemoveBtnClick: () {
              num? productCount = buyBasketList[index].productCountInBasket;
              //if product count is more than 1 in basket remove 1 else remove product totally
              if (productCount! > 1) {
                shoppingController
                    .removeProductFromBasket(buyBasketList[index]);
              } else {
                Get.dialog(CustomAlertDialog(
                  messageTxt: 'محصول از سبد خرید حذف شود؟',
                  onOkTap: () {
                    Get.back();
                    shoppingController
                        .removeProductFromBasket(buyBasketList[index]);
                  },
                  confirmBtnTxt: 'بله',
                  negativeBtnTxt: 'خیر',
                  onNoTap: () => Get.back(),
                ));
              }
            },
            product: buyBasketList[index],
            productIndex: index,
          );
        });
  }

  Widget _completeShopping(ShoppingCartController controller) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          GetBuilder<CategoryController>(builder: (logic) {
            return CustomButton(
              onTap: () {
                if (controller.allProductStock()) {
                  _emptyShoppingCart(controller, logic);
                } else {
                  Get.dialog(CustomAlertDialog(
                    messageTxt: 'موجودی محصولات انتخابی کافی نیست.',
                    onOkTap: () => Get.back(),
                    confirmBtnTxt: 'بستن',
                  ));
                }
              },
              buttonText: 'تکمیل خرید',
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              buttonWidth: 150,
              buttonHeight: 40,
              textSize: AppSizes.littleTextSize,
            );
          }),
          const Spacer(),
          CustomText(
              text:
              'مجموع خریدها: ${controller.totalShoppingCart()
                  .toString()} تومان '),
        ],
      ),
    );
  }

  Future<void> _emptyShoppingCart(ShoppingCartController catController, CategoryController categoryController) async {

    int allShopping = 0;
    // search each item in product and check their availability
    for (var cartProduct in buyBasketList) {
      for (var product in productList) {
        if ((cartProduct.id == product.id) &&
            (cartProduct.productCountInBasket! <=
                product.totalProductCount!)) {

          // reduce product availability
          product.totalProductCount = product.totalProductCount! -
              cartProduct.productCountInBasket!;
          product.productCountInBasket = 0;

          await productController.editProduct(product).then((value) async {
            // find product in categories and delete its availability from it
            for (var category in categoryList) {
              if (category.name == product.productCategory) {
                for (int i = 0; i< category.productsList!.length ; i++) {
                  if (category.productsList![i].id == product.id) {
                    category.productsList![i] = product;
                    await categoryController.editCategory(category).then((value){
                      allShopping += 1;
                    });
                    break;
                  }
                }
              }
            }
          });
        }
      }
    }

    if(allShopping == buyBasketList.length){
      catController.emptyShoppingCart();
      Get.snackbar('انجام شد', '***خرید با موفقیت انجام شد. از اعتماد شما متشکریم***');
    }
    else{
      Get.snackbar('خطا', 'خطایی رخ داده است! لطفا مجددا تلاش کنید.');
    }

  }
}
