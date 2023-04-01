import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/controllers/favorites_controller.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/models/favorites.dart';
import 'package:shop_getx/models/product_category.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';
import 'package:shop_getx/views/pages/add_edit_product_page.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/product_item.dart';

import '../../controllers/shopping_cart_controller.dart';
import '../../controllers/tag_controller.dart';
import '../../shared_class/custom_search.dart';

class AllProductListPage extends GetView {
  AllProductListPage(this.category, {Key? key}) : super(key: key);

  final ProductCategory category;
  bool isUserAdmin =
      AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!;

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
            return GetBuilder<CategoryController>(
                builder: (categoryController) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: category.productsList!.length,
                  itemBuilder: (context, index) {
                    return isUserAdmin
                        ? _removableItem(index, categoryController)
                        : _noRemovableItem(
                            index, favoritesController, shoppingController);
                  });
            });
          },
        );
      },
    );
  }

  Widget _removableItem(int index, CategoryController categoryController) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          controller.deleteProduct(category.productsList![index]).then((value) {
            category.productsList!.remove(category.productsList![index]);
            categoryController.editCategory(category);
          });
        },
        background: Container(
          color: AppColors.primaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: const Icon(
            Icons.delete,
            size: 50,
            color: Colors.white,
          ),
        ),
        child: ProductItem(
          isFade: category.productsList![index].totalProductCount! == 0
              ? true
              : false,
          iconLike: false,
          onItemClick: () {
            Get.to(() => AddEditProductPage(
                product: category.productsList![index], category: category));
          },
          product: category.productsList![index],
          productIndex: index,
        ));
  }

  Widget _noRemovableItem(int index, FavoritesController favController,
      ShoppingCartController shoppingController) {
    if (category.productsList![index].isProductHide!) {
      return const SizedBox();
    } else if (category.productsList![index].totalProductCount! == 0) {
      return ProductItem(
          isFade: true,
          product: category.productsList![index],
          productIndex: index,
          iconLike: false);
    } else {
      return ProductItem(
        isFade: false,
        onIconLikeTap: () {
          favController.editFavoriteList(category.productsList![index]);
        },
        iconLike:
            favController.searchItemInFavorites(category.productsList![index]),
        onItemClick: () => Get.to(
            () => ProductDetailsPage(product: category.productsList![index])),
        addToBasketClick: () {
          shoppingController.editShoppingCart(category.productsList![index]);
        },
        onAddBtnClick: () {
          shoppingController
              .searchProductInBasket(category.productsList![index]);
          shoppingController
              .editShoppingCart(shoppingController.targetProduct!);
        },
        onRemoveBtnClick: () {
          shoppingController
              .searchProductInBasket(category.productsList![index]);
          shoppingController
              .removeProductFromBasket(shoppingController.targetProduct!);
          changeProductCountInBasket(index, favController);
        },
        product: shoppingController
                .searchProductInBasket(category.productsList![index])
            ? shoppingController.targetProduct!
            : category.productsList![index],
        productIndex: index,
      );
    }
  }

  Widget _floatingActionButton() {
    if (isUserAdmin) {
      return FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.to(() => AddEditProductPage(
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

  void changeProductCountInBasket(
      int index, FavoritesController favoritesController) {
    // if target product is in favoriteList and it has 1 product count in basket
    for (var favItem in favoritesList) {
      if (favItem.id == category.productsList![index].id &&
          favItem.productCountInBasket == 1) {
        favItem.productCountInBasket = favItem.productCountInBasket! - 1;
        favoritesController.editFavoriteListInServer();
      }
    }

    // if product count in basket was 1 it should change its count
    if (category.productsList![index].productCountInBasket! == 1) {
      category.productsList![index].productCountInBasket =
          category.productsList![index].productCountInBasket! - 1;
    }
  }
}
