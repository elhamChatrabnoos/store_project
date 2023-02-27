import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

import '../../../controllers/product_controller.dart';
import '../../widgets/product_item.dart';

class ShopBasketPage extends StatelessWidget {
  ShopBasketPage({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buyBasketList.isNotEmpty
          ? _productList()
          : Center(
        child: CustomText(
            text: 'سبد خرید شما خالی است',
            textSize: AppSizes.normalTextSize1,
            textColor: AppColors.grayColor),
      ),
    );
  }

  Widget _productList() {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: buyBasketList.length,
            itemBuilder: (context, index) {
              return ProductItem(
                onAddBtnClick: () =>
                    productController.addProductToBasket(buyBasketList[index]),
                onRemoveBtnClick: () {
                  int productCount = buyBasketList[index].productCount;
                  if (productCount > 1) {
                    productController.removeProductFromBasket(
                        buyBasketList[index]);
                  } else {
                    buyBasketList.removeAt(index);
                  }
                },
                product: buyBasketList[index],
                productIndex: index,
              );
            });
  }
}
