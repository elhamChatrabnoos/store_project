import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/favorites_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';
import 'package:shop_getx/views/pages/add_product_page.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/product_item.dart';

import '../../controllers/product_controller.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../models/product.dart';
import '../../shared_class/custom_search.dart';

class AllProductListPage extends GetView{
  AllProductListPage(
      this.productList,
      this.categoryName,
      {Key? key}) : super(key: key);

  final List<Product> productList;
  final String categoryName;

  bool isUserAdmin = AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!;
  // FavoritesController favController = Get.put(FavoritesController());
  // ShoppingCartController shoppingCartController = Get.put(ShoppingCartController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShoppingCartController());
    Get.lazyPut(() => FavoritesController());
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
        return GetBuilder<FavoritesController>(
          assignId: true,
          builder: (favoritesController) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return _productItem(
                      index, favoritesController, shoppingController);
                });
          },
        );
      },
    );
  }

  Widget _productItem(int index, FavoritesController favController,
      ShoppingCartController shoppingController) {
    return isUserAdmin
        ? ProductItem(
            iconLike: false,
            onItemClick: () {
              Get.to(() => AddProductPage());
            },
            product: productList[index],
            productIndex: index,
          )
        : ProductItem(
            onIconLikeTap: () {
              favController.editFavoriteList(productList[index]);
            },
            iconLike: favController.searchItemInFavorites(productList[index]),
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
              shoppingController
                  .removeProductFromBasket(shoppingController.targetProduct!);
            },
            product:
                shoppingController.searchProductInBasket(productList[index])
                    ? shoppingController.targetProduct!
                    : productList[index],
            productIndex: index,
          );
  }

  Widget _floatingActionButton() {
    if (isUserAdmin) {
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
