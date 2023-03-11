import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/controllers/favorites_controller.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/models/product_category.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';
import 'package:shop_getx/views/pages/add_edit_product_page.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/product_item.dart';

import '../../controllers/shopping_cart_controller.dart';
import '../../shared_class/custom_search.dart';

class AllProductListPage extends GetView {
  AllProductListPage(this.category, {Key? key}) : super(key: key);

  final ProductCategory category;
  bool isUserAdmin =
  AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!;
  ProductController productController = Get.put(ProductController());

  // FavoritesController favController = Get.put(FavoritesController());
  // ShoppingCartController shoppingCartController = Get.put(ShoppingCartController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShoppingCartController());
    Get.lazyPut(() => FavoritesController());
    Get.lazyPut(() => CategoryController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                delegate:
                CustomSearchDelegate(targetList: category.productsList!),
                // delegate to customize the search bar
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _productsList(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _productsList() {
    return GetBuilder<ShoppingCartController>(
      assignId: true,
      builder: (shoppingController) {
        return GetBuilder<FavoritesController>(
          assignId: true,
          builder: (favoritesController) {
            return GetBuilder<CategoryController>(builder: (categoryController) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: category.productsList!.length,
                  itemBuilder: (context, index) {
                    return isUserAdmin
                        ? _removableItem(
                        index, favoritesController, shoppingController,categoryController )
                        : _noRemovableItem(
                        index, favoritesController, shoppingController);
                  });
            });
          },
        );
      },
    );
  }

  Widget _removableItem(int index, FavoritesController favoritesController,
      ShoppingCartController shoppingController, CategoryController categoryController) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          productController.deleteProduct(category.productsList![index]);
          category.productsList!.remove(category.productsList![index]);
          categoryController.editCategory(category);
        },
        background: Container(
          color: AppColors.primaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            size: 50,
            color: Colors.white,
          ),
        ),
        // Display item's title, price...
        child: ProductItem(
          iconLike: false,
          onItemClick: () {
            Get.off(() =>
                AddEditProductPage(
                    product: category.productsList![index],
                    category: category));
          },
          product: category.productsList![index],
          productIndex: index,
        ));
  }

  Widget _noRemovableItem(int index, FavoritesController favController,
      ShoppingCartController shoppingController) {
    return ProductItem(
      onIconLikeTap: () {
        favController.editFavoriteList(category.productsList![index]);
      },
      iconLike:
      favController.searchItemInFavorites(category.productsList![index]),
      onItemClick: () {
        Get.to(
                () =>
                ProductDetailsPage(product: category.productsList![index]));
      },
      addToBasketClick: () {
        shoppingController.editShoppingCart(category.productsList![index]);
      },
      onAddBtnClick: () {
        shoppingController.searchProductInBasket(category.productsList![index]);
        shoppingController.editShoppingCart(shoppingController.targetProduct!);
      },
      onRemoveBtnClick: () {
        shoppingController.searchProductInBasket(category.productsList![index]);
        shoppingController
            .removeProductFromBasket(shoppingController.targetProduct!);
      },
      product: shoppingController
          .searchProductInBasket(category.productsList![index])
          ? shoppingController.targetProduct!
          : category.productsList![index],
      productIndex: index,
    );
  }

  Widget _floatingActionButton() {
    if (isUserAdmin) {
      return FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.off(() =>
              AddEditProductPage(
                category: category,
              ));
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
