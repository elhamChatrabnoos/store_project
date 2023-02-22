import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_button.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key? key,
    required this.product,
    required this.addToBasketClick,
    required this.onItemClick})
      : super(key: key);

  final Function() addToBasketClick;
  final Function() onItemClick;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: onItemClick,
        child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
            child: Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _productImage(),
                      _titleAndDescription(),
                      const Spacer(),
                      _buyAndCost()
                    ]),
                AppSizes.littleSizeBox2,
                const Divider(
                  height: 15,
                  color: Colors.grey,
                )
              ],
            )),
      ),
    );
  }

  Widget _buyAndCost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceText(),
        AppSizes.littleSizeBox2,
        product.productDiscount != null ? _productDiscount() : const SizedBox(),
        AppSizes.normalSizeBox2,
        product.productCount! <= 0 ? CustomButton(
          onTap: addToBasketClick,
          textSize: 13,
          buttonHeight: 30,
          buttonWidth: 130,
          buttonText: 'افزودن به سبد خرید',
          textColor: Colors.blue,
        ) : _addDeleteProduct(),
      ],
    );
  }

  Column _titleAndDescription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.littleSizeBox,
        CustomText(text: product.productName!, textSize: 17),
        AppSizes.littleSizeBox,
        _descriptionText(),
        AppSizes.littleSizeBox2,
      ],
    );
  }

  Widget _descriptionText() {
    return CustomText(
      text: product.isAvailable! ? 'موجود در انبار' : 'موجودی به اتمام رسیده',
      textSize: 15,
      textWeight: FontWeight.normal,
      textColor: product.isAvailable! ? Colors.green : Colors.red,
    );
  }

  Widget _priceText() {
    return CustomText(
        text: product.productDiscount != null
            ? '${product.productPrice! -
            product.productPrice! * product.productDiscount! ~/ 100} تومان '
            : '${product.productPrice} تومان ',
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
    return Align(
        alignment: Alignment.center,
        child: Image.asset(
          product.productImage!,
          width: 100,
          height: 100,
        ));
  }

  Widget _addDeleteProduct() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.deepButtonColor)),
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.add, size: 20, color: AppColors.deepButtonColor),
          CustomText(text: product.productCount.toString(),
              textColor: AppColors.deepButtonColor),
          Icon(Icons.delete, size: 20, color: AppColors.deepButtonColor),
        ],
      ),
    );
  }
}
