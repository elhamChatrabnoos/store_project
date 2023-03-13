import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/views/pages/bottom_navigation_pages/favorits_page.dart';

import '../../controllers/shopping_cart_controller.dart';
import 'bottom_navigation_pages/home_page.dart';
import 'bottom_navigation_pages/shopping_cart_page.dart';

class MainPage extends GetView {
  MainPage({Key? key}) : super(key: key);

  List bottomBarPages = [FavoritesPage(), HomePage(), ShoppingCartPage()];
  PageController pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShoppingCartController());

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar:
          (bottomBarPages.length < 4) ? _bottomBarItems() : null,
    );
  }

  Widget _bottomBarItems() {
    return AnimatedNotchBottomBar(

      itemLabelStyle: TextStyle(color: AppColors.navInactiveItemColor),
      color: AppColors.bottomNavBackColor,
      notchColor: AppColors.bottomNavItemColor,
      pageController: pageController,
      bottomBarItems: [
        BottomBarItem(
            itemLabel: LocaleKeys.HomePage_favoritesBtn.tr,
            inActiveItem: Icon(Icons.favorite_border,
                color: AppColors.navInactiveItemColor),
            activeItem:
                Icon(Icons.favorite, color: AppColors.navActiveItemColor)),
        BottomBarItem(
            itemLabel: LocaleKeys.HomePage_homeBtn.tr,
            inActiveItem: Icon(
              Icons.home_outlined,
              color: AppColors.navInactiveItemColor,
            ),
            activeItem:
                Icon(Icons.home_filled, color: AppColors.navActiveItemColor)),
        BottomBarItem(
            itemLabel: LocaleKeys.HomePage_shoppingCartBtn.tr,
            inActiveItem: Icon(Icons.shopping_basket_outlined,
                color: AppColors.navInactiveItemColor),
            activeItem: Icon(Icons.shopping_basket,
                color: AppColors.navActiveItemColor)),
      ],
      onTap: (index) {
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }
}
