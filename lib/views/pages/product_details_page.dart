import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/core/app_texts.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../widgets/custom_button.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text(AppTexts.productDetailTitle)),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(product.productImage!,
                      width: MediaQuery.of(context).size.width, height: 250),
                  _productName(),
                  AppSizes.littleSizeBox,
                  _discountCost(),
                  AppSizes.littleSizeBox,
                  _productPrice(),
                  AppSizes.normalSizeBox2,
                  const CustomText(text: 'محصولات مشابه', textSize: 20),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        HomeProductItem(product: productList[index]);
                      },
                    ),
                  )
                ],
              ))),
    );
  }

  Widget _productPrice() {
    return Row(
      children: [
        CustomText(
            text: product.productDiscount != null
                ? '${product.productPrice! - product.productPrice! * product.productDiscount! ~/ 100} تومان '
                : '${product.productPrice} تومان ',
            textSize: AppSizes.normalTextSize),
        const Spacer(),
        CustomButton(
          onTap: null,
          textSize: 15,
          buttonHeight: 40,
          buttonWidth: 160,
          buttonText: 'افزودن به سبد خرید',
          textColor: Colors.white,
          buttonColor: Colors.lightBlueAccent,
        ),
      ],
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
              textSize: AppSizes.subTitleTextSize,
              textWeight: FontWeight.bold,
              textColor: Colors.white,
            )),
        AppSizes.littleSizeBox2Width,
        CustomText(
          text: product.productPrice.toString(),
          textDecoration: TextDecoration.lineThrough,
          decorationColor: const Color.fromARGB(255, 119, 117, 117),
          textSize: AppSizes.subTitleTextSize,
          textColor: const Color.fromARGB(255, 140, 140, 140),
        ),
      ],
    );
  }
}
