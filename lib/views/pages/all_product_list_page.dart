import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';
import 'package:shop_getx/views/pages/add_product_page.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/product_item.dart';

import '../../controllers/product_controller.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../shared_class/custom_search.dart';

class AllProductListPage extends GetView<ShoppingCartController> {
  AllProductListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShoppingCartController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
                // delegate to customize the search bar
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _productList(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _productList() {
    return GetBuilder<ShoppingCartController>(
      assignId: true,
      builder: (shoppingController) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _productItem(index, shoppingController);
            });
      },
    );
  }

  Widget _productItem(int index, ShoppingCartController shoppingController) {
    return AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!
        ? ProductItem(
            onItemClick: () {
              Get.to(() => AddProductPage());
            },
            product: productList[index],
            productIndex: index,
          )
        : ProductItem(
            onItemClick: () {
              Get.to(() => ProductDetailsPage(product: productList[index]));
            },
            addToBasketClick: () {
              shoppingController.editShoppingCart(productList[index]);
            },
            onAddBtnClick: () {
              shoppingController.searchProductInBasket(productList[index]);
              shoppingController
                  .editShoppingCart(shoppingController.targetProduct!);
            },
            onRemoveBtnClick: () {
              shoppingController.searchProductInBasket(productList[index]);
              shoppingController.removeProductFromBasket(
                  shoppingController.targetProduct!);
            },
            product:
                shoppingController.searchProductInBasket(productList[index])
                    ? shoppingController.targetProduct!
                    : productList[index],
            productIndex: index,
          );
  }

  Widget _floatingActionButton() {
    if (AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!) {
      return FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.to(() => AddProductPage());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
