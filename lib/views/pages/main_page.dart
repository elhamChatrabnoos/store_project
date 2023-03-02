import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/main_page_controller.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/core/app_colors.dart';

import '../../controllers/user_controller.dart';
import 'bottom_navigation_pages/buy_basket_page.dart';
import 'bottom_navigation_pages/home_page.dart';
import 'bottom_navigation_pages/profile_page.dart';

class MainPage extends GetView<ProductController> {
  MainPage({Key? key}) : super(key: key);

  List bottomBarPages = [UserProfilePage(), HomePage(), ShopBasketPage()];
  final pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar:
          (bottomBarPages.length <= 3) ? _bottomBarItems() : null,
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
            itemLabel: 'پروفایل',
            inActiveItem: Icon(Icons.account_box_outlined,
                color: AppColors.navInactiveItemColor),
            activeItem:
                Icon(Icons.account_box, color: AppColors.navActiveItemColor)),
        BottomBarItem(
            itemLabel: 'خانه',
            inActiveItem: Icon(
              Icons.home_outlined,
              color: AppColors.navInactiveItemColor,
            ),
            activeItem:
                Icon(Icons.home_filled, color: AppColors.navActiveItemColor)),
        BottomBarItem(
            itemLabel: 'سبد خرید',
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
