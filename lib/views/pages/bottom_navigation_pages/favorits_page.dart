import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/client/favorites_controller.dart';
import 'package:shop_getx/controllers/client/shopping_cart_controller.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/models/favorites.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/custom_dialog.dart';
import 'package:shop_getx/views/widgets/product_item.dart';

import '../../../core/app_sizes.dart';
import '../../widgets/custom_text.dart';

class FavoritesPage extends GetView {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FavoritesController());
    Get.lazyPut(() => ShoppingCartController());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(LocaleKeys.HomePage_favoritesBtn.tr)),
      body: favoritesList.isNotEmpty
          ? _favoritesList()
          : Center(
              child: CustomText(
                  text: LocaleKeys.Favorites_page_noFavoriteMsg.tr,
                  textSize: AppSizes.normalTextSize1,
                  textColor: Colors.black),
            ),
    );
  }

  Widget _favoritesList() {
    return GetBuilder<ShoppingCartController>(
      assignId: true,
      builder: (shoppingController) {
        return GetBuilder<FavoritesController>(
          assignId: true,
          builder: (favoritesController) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: favoritesList.length,
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
    return ProductItem(
      onIconLikeTap: () {
        Get.dialog(CustomAlertDialog(
          messageTxt: LocaleKeys.Favorites_page_removeFromFavoriteMsg.tr,
          onOkTap: () {
            Get.back();
            favController.editFavoriteList(favoritesList[index]);
          },
          confirmBtnTxt: LocaleKeys.Dialogs_message_yesBtn.tr,
          negativeBtnTxt: LocaleKeys.Dialogs_message_noBtn.tr,
          onNoTap: () => Get.back(),
        ));
      },
      iconLike: favController.searchItemInFavorites(favoritesList[index]),
      onItemClick: () {
        // Get.to(() => ProductDetailsPage(product: favoritesList[index]));
      },
      addToBasketClick: () {
        shoppingController.editShoppingCart(favoritesList[index]);
      },
      onAddBtnClick: () {
        shoppingController.searchProductInBasket(favoritesList[index]);
        shoppingController.editShoppingCart(shoppingController.targetProduct!);
      },
      onRemoveBtnClick: () {
        shoppingController.searchProductInBasket(favoritesList[index]);
        shoppingController
            .removeProductFromBasket(shoppingController.targetProduct!);
        if (favoritesList[index].productCountInBasket! == 1) {
          favoritesList[index].productCountInBasket =
              favoritesList[index].productCountInBasket! - 1;
        }
      },
      product: shoppingController.searchProductInBasket(favoritesList[index])
          ? shoppingController.targetProduct!
          : favoritesList[index],
      productIndex: index,
      isFade: false,
    );
  }
}
