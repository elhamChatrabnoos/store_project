import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_button.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

class ProductItem extends StatelessWidget {
  ProductItem(
      {Key? key,
      required this.product,
      required this.addToBasket})
      : super(key: key);

  final Function() addToBasket;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
                height: 10,
                color: Colors.grey,
              )
            ],
          )),
    );
  }

  Column _buyAndCost() {
    return Column(
      children: [
        CustomButton(
          onTap: addToBasket,
          textSize: 13,
          buttonHeight: 30,
          buttonWidth: 130,
          buttonText: 'افزودن به سبد خرید',
          textColor: Colors.blue,
        ),
        Container(
          height: 50,
          child: product.productDiscount != null
              ? _productDiscount()
              : const SizedBox(),
        ),
        _priceText(),
        AppSizes.littleSizeBox,
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
}
