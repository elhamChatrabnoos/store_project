import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/main_page_controller.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/core/app_colors.dart';

class MainPage extends GetView<MainController>{
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainController());
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: List.generate(controller.bottomBarPages.length,
            (index) => controller.bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar:
          (controller.bottomBarPages.length <= controller.maxCount)
              ? _bottomBarItems()
              : null,
    );
  }

  Widget _bottomBarItems() {
    return AnimatedNotchBottomBar(
      itemLabelStyle: TextStyle(color: AppColors.navInactiveItemColor),
      color: AppColors.bottomNavBackColor,
      notchColor: AppColors.bottomNavItemColor,
      pageController: controller.pageController,
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
        controller.pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }
}
