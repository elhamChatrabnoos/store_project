import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/image_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

import 'future_image.dart';

class HomeProductItem extends GetView<ImageController> {
  HomeProductItem({
    this.onLongPress,
    Key? key,
    required this.product,
    this.onItemClick,
  }) : super(key: key);

  Function()? onItemClick;
  final Product product;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return InkWell(
      onLongPress: onLongPress,
      onTap: onItemClick,
      child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _productImage(),
                AppSizes.littleSizeBox,
                CustomText(text: product.productName!, textSize: 17),
                _descriptionText(),
                AppSizes.littleSizeBox2,
                product.productDiscount != 0
                    ? _productDiscount()
                    : const SizedBox(height: 20),
                AppSizes.littleSizeBox2,
                _priceText()
              ],
            ),
          )),
    );
  }

  Widget _descriptionText() {
    return SizedBox(
      width: 120,
      child: CustomText(
        overflow: TextOverflow.ellipsis,
        text: product.productDescription!,
        textSize: 13,
        textWeight: FontWeight.normal,
        textColor: AppColors.subTextColor,
      ),
    );
  }

  Widget _priceText() {
    return CustomText(
        text: product.productDiscount != null
            ? '${product.productPrice! - product.productPrice! * product.productDiscount! ~/ 100} ${LocaleKeys.Product_item_moneyUnit.tr} '
            : '${product.productPrice} ${LocaleKeys.Product_item_moneyUnit.tr} ',
        textSize: 15);
  }

  Widget _productDiscount() {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: CustomText(
              text: '${product.productDiscount}%',
              textSize: 14,
              textWeight: FontWeight.bold,
              textColor: Colors.white,
            )),
        AppSizes.littleSizeBox2Width,
        CustomText(
          text: product.productPrice.toString(),
          textDecoration: TextDecoration.lineThrough,
          decorationColor: Color(0xFF575757),
          textSize: 14,
          textColor: const Color.fromARGB(255, 140, 140, 140),
        ),
      ],
    );
  }

  Widget _productImage() {
    return Align(
        alignment: Alignment.center,
        child: FutureImage(
          future: controller.stringToImage(product.productImage),
          imageSize: 100,
        ));
  }
}
