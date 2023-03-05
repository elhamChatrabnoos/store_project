import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/core/app_texts.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../../controllers/product_controller.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../models/shopping_cart.dart';
import '../widgets/custom_button.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  // final ShoppingCartController controller = Get.find<ShoppingCartController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFECE9EB),
        appBar:
        AppBar(centerTitle: true, title: Text(AppTexts.productDetailTitle)),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topPartPage(context),
                  AppSizes.littleSizeBox,
                  _bottomPartPage()
                ],
              )),
        ));
  }

  Widget _bottomPartPage() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
              text: ' توضیحات محصول',
              textColor: Colors.blue,
              textSize: 17,
              textWeight: FontWeight.normal),
          AppSizes.littleSizeBox,
          _longDescription(),
          AppSizes.littleSizeBox,
          const Divider(height: 20, color: Color(0xFF5CC2FA)),
          AppSizes.littleSizeBox,
          CustomText(
              text: 'محصولات مشابه', textSize: AppSizes.subTitleTextSize),
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
          Image.asset(product.productImage!,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 4),
          _productName(),
          AppSizes.littleSizeBox,
          _discountCost(),
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
                ? '${product.productPrice! -
                product.productPrice! * product.productDiscount! ~/ 100} تومان '
                : '${product.productPrice} تومان ',
            textSize: AppSizes.subTitleTextSize),
        const Spacer(),
        _checkProductInBasket(),
      ],
    );
  }

  Widget _checkProductInBasket() {
    int indexOfProduct = buyBasketList.indexOf(product);
    if (indexOfProduct > -1) {
      return _addDeleteProduct();
    } else {
      return GetBuilder<ProductController>(
        assignId: true,
        builder: (controller) {
          return CustomButton(
            onTap: () =>
            {
              // controller.addProductToBasket(product),
            },
            textSize: 13,
            buttonHeight: 30,
            buttonWidth: 130,
            buttonText: 'افزودن به سبد خرید',
            textColor: Colors.blue,
          );
        },
      );
    }
  }

  // Todo create widget for this
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
          InkWell(
            onTap: () {
              // controller.addProductToBasket(product);
            },
            child: Icon(Icons.add, size: 20, color: AppColors.deepButtonColor),
          ),
          CustomText(
              text: product.productCountInBasket.toString(),
              textColor: AppColors.deepButtonColor),
          InkWell(
            onTap: () {
              // controller.removeProductFromBasket(product)
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
          text: product.productPrice.toString(),
          textDecoration: TextDecoration.lineThrough,
          decorationColor: const Color.fromARGB(255, 119, 117, 117),
          textSize: AppSizes.normalTextSize1,
          textColor: const Color.fromARGB(255, 140, 140, 140),
        ),
      ],
    );
  }
}
