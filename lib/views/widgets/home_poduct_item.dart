import 'package:flutter/material.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

class HomeProductItem extends StatelessWidget {
  HomeProductItem({
    Key? key,
    required this.product,
    this.onItemClick,
  }) : super(key: key);

  Function()? onItemClick;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                product.productDiscount != null
                    ? _productDiscount()
                    : const SizedBox(),
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
            ? '${product.productPrice! - product.productPrice! * product.productDiscount! ~/ 100} تومان '
            : '${product.productPrice} تومان ',
        textSize: 15);
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
        child: Image.asset(
          product.productImage!,
          width: 100,
          height: 100,
        ));
  }
}
