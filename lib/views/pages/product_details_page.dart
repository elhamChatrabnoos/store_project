import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../../controllers/shared/image_controller.dart';
import '../../controllers/shared/product_controller.dart';
import '../../controllers/client/shopping_cart_controller.dart';
import '../../generated/locales.g.dart';
import '../../models/shopping_cart.dart';
import '../widgets/custom_button.dart';
import '../widgets/future_image.dart';

class ProductDetailsPage extends GetView {
  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  // final ShoppingCartController _shoppingCartController =
  //     Get.put(ShoppingCartController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    Get.lazyPut(() => ShoppingCartController());

    return Scaffold(
      backgroundColor: AppColors.grayColor,
      appBar: AppBar(
          centerTitle: true, title: Text(LocaleKeys.Details_page_title.tr)),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topPartPage(context),
              AppSizes.littleSizeBox,
              _bottomPartPage()
            ],
          )),
    );
  }

  Widget _bottomPartPage() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: LocaleKeys.Add_product_page_productDescription.tr,
              textColor: Colors.blue,
              textSize: 17,
              textWeight: FontWeight.normal),
          AppSizes.littleSizeBox,
          _longDescription(),
          AppSizes.littleSizeBox,
          const Divider(height: 20, color: Color(0xFF5CC2FA)),
          AppSizes.littleSizeBox,
          CustomText(
              text: LocaleKeys.Details_page_similarProduct.tr,
              textSize: AppSizes.subTitleTextSize),
          AppSizes.littleSizeBox,
          _listOfSimilarProduct(),
        ],
      ),
    );
  }

  Widget _topPartPage(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<ImageController>(
            assignId: true,
            builder: (imageController) {
              return Align(
                  alignment: Alignment.center,
                  child: FutureImage(
                    future: imageController.stringToImage(product.productImage),
                    imageSize: 200,
                  ));
            },
          ),
          AppSizes.littleSizeBox,
          _productName(),
          AppSizes.littleSizeBox,
          product.productDiscount != 0 ? _discountCost() : const SizedBox(),
          AppSizes.littleSizeBox,
          _productPriceAndToBasket(),
        ],
      ),
    );
  }

  Widget _longDescription() {
    return CustomText(
      text: product.productDescription!,
      textSize: AppSizes.normalTextSize1,
      textWeight: FontWeight.normal,
    );
  }

  Widget _listOfSimilarProduct() {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return HomeProductItem(
            product: productList[index],
          );
        },
      ),
    );
  }

  Widget _productPriceAndToBasket() {
    return Row(
      children: [
        CustomText(
            text: product.productDiscount != null
                ? '${product.productPrice! - product.productPrice! * product.productDiscount! ~/ 100} ${LocaleKeys.Product_item_moneyUnit.tr} '
                : '${product.productPrice} ${LocaleKeys.Product_item_moneyUnit.tr} ',
            textSize: AppSizes.subTitleTextSize),
        const Spacer(),
        GetBuilder<ShoppingCartController>(
          assignId: true,
          builder: (logic) {
            return _checkProductInBasket(logic);
          },
        ),
      ],
    );
  }

  Widget _checkProductInBasket(ShoppingCartController shoppingController) {
    if (shoppingController.searchProductInBasket(product)) {
      return _addDeleteProduct(shoppingController);
    } else {
      return CustomButton(
        onTap: () {
          shoppingController.editShoppingCart(product);
        },
        textSize: 13,
        buttonText: LocaleKeys.Product_item_addToShoppingCart.tr,
        textColor: Colors.blue,
      );
    }
  }

  Widget _addDeleteProduct(ShoppingCartController shoppingController) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.deepButtonColor)),
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              shoppingController.searchProductInBasket(product);
              shoppingController
                  .editShoppingCart(shoppingController.targetProduct!);
            },
            child: Icon(Icons.add, size: 20, color: AppColors.deepButtonColor),
          ),
          CustomText(
              text: shoppingController.targetProduct!.productCountInBasket.toString(),
              textColor: AppColors.deepButtonColor),
          InkWell(
            onTap: () {
              shoppingController.searchProductInBasket(product);
              shoppingController
                  .removeProductFromBasket(shoppingController.targetProduct!);
            },
            child:
                Icon(Icons.delete, size: 20, color: AppColors.deepButtonColor),
          )
        ],
      ),
    );
  }

  Widget _productName() {
    return CustomText(
      text: product.productName!,
      textSize: AppSizes.titleTextSize,
      decorationColor: Colors.grey,
    );
  }

  Widget _discountCost() {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: CustomText(
              text: '${product.productDiscount}%',
              textSize: AppSizes.normalTextSize1,
              textWeight: FontWeight.bold,
              textColor: Colors.white,
            )),
        AppSizes.littleSizeBox2Width,
        CustomText(
          text: '${product.productPrice.toString()} ${LocaleKeys.Product_item_moneyUnit.tr}',
          textDecoration: TextDecoration.lineThrough,
          decorationColor: const Color.fromARGB(255, 119, 117, 117),
          textSize: AppSizes.normalTextSize1,
          textColor: const Color.fromARGB(255, 140, 140, 140),
        ),
      ],
    );
  }
}
