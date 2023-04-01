import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/image_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_button.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/future_image.dart';

class ProductItem extends GetView<ImageController> {
  ProductItem(
      {required this.isFade,
      Key? key,
      required this.product,
      this.addToBasketClick,
      this.onItemClick,
      this.onAddBtnClick,
      this.onRemoveBtnClick,
      required this.productIndex,
      this.onIconLikeTap,
      required this.iconLike})
      : super(key: key);

  final Function()? addToBasketClick;
  final Function()? onItemClick;
  final Function()? onAddBtnClick;
  final Function()? onRemoveBtnClick;
  final Function()? onIconLikeTap;
  final bool iconLike;
  Product product;
  final int productIndex;
  final bool isFade;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return InkWell(
      onTap: onItemClick,
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
              child: Column(
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _productImage(),
                        AppSizes.normalSizeBoxWidth,
                        _titleAndDescription(),
                        const Spacer(),
                        _buyAndCost()
                      ]),
                  AppSizes.littleSizeBox,
                  const Divider(
                    height: 15,
                    color: Colors.grey,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buyAndCost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _priceText(),
        AppSizes.littleSizeBox2,
        product.productDiscount != 0 ? _productDiscount() : const SizedBox(),
        AppSizes.normalSizeBox2,
        _checkProductInBasket(),
      ],
    );
  }

  Widget _checkProductInBasket() {
    // print('count is ${product.productCountInBasket}');
    if (product.productCountInBasket! > 0) {
      return _addDeleteProduct();
    } else {
      return CustomButton(
        onTap: addToBasketClick,
        textSize: 13,
        buttonHeight: 30,
        buttonText: LocaleKeys.Product_item_addToShoppingCart.tr,
        textColor: Colors.blue,
      );
    }
  }

  Column _titleAndDescription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.littleSizeBox,
        CustomText(text: product.productName!, textSize: 17),
        AppSizes.littleSizeBox,
        _isAvailableProduct(),
        AppSizes.littleSizeBox,
        SizedBox(
          width: 110,
          child: CustomText(
              overflow: TextOverflow.ellipsis,
              text: product.productDescription!,
              textWeight: FontWeight.normal,
              textSize: 12),
        )
      ],
    );
  }

  Widget _isAvailableProduct() {
    return CustomText(
      text: isFade
          ? LocaleKeys.Add_product_page_isNotAvailable.tr
          : LocaleKeys.Product_item_available.tr,
      textSize: 15,
      textWeight: FontWeight.normal,
      textColor: isFade ? Colors.red : Colors.green,
    );
  }

  Widget _priceText() {
    return CustomText(
        text: product.productDiscount != null
            ? '${product.productPrice! - product.productPrice! * product.productDiscount! ~/ 100} ${LocaleKeys.Product_item_moneyUnit.tr} '
            : '${product.productPrice} ${LocaleKeys.Product_item_moneyUnit.tr} ',
        textSize: 18);
  }

  Widget _productDiscount() {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: CustomText(
              text: '${product.productDiscount}%',
              textSize: 12,
              textWeight: FontWeight.bold,
              textColor: Colors.white,
            )),
        AppSizes.littleSizeBox2Width,
        CustomText(
          text: product.productPrice.toString(),
          textDecoration: TextDecoration.lineThrough,
          decorationColor: const Color.fromARGB(255, 0, 0, 0),
          textSize: 14,
          textColor: const Color.fromARGB(255, 140, 140, 140),
        ),
      ],
    );
  }

  Widget _productImage() {
    return Column(
      children: [
        FutureImage(
            future: controller.stringToImage(product.productImage),
            imageSize: 100),
        IconButton(
          onPressed: onIconLikeTap,
          icon: iconLike
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
        )
      ],
    );
  }

  Widget _addDeleteProduct() {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.deepButtonColor)),
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: onAddBtnClick,
              icon:
                  Icon(Icons.add, size: 20, color: AppColors.deepButtonColor)),
          CustomText(
              text: product.productCountInBasket.toString(),
              textColor: AppColors.deepButtonColor),
          IconButton(
            onPressed: onRemoveBtnClick,
            icon:
                Icon(Icons.delete, size: 20, color: AppColors.deepButtonColor),
          )
        ],
      ),
    );
  }
}
