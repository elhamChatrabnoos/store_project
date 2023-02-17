import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/home_page_controller.dart';
import 'package:shop_getx/core/app_colors.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: homeController.pageController,
        children: List.generate(homeController.bottomBarPages.length,
            (index) => homeController.bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar:
          (homeController.bottomBarPages.length <= homeController.maxCount)
              ? _bottomBarItems()
              : null,
    );
  }

  Widget _bottomBarItems() {
    return AnimatedNotchBottomBar(
          itemLabelStyle: TextStyle(color: AppColors.navInactiveItemColor),
          color: AppColors.bottomNavBackColor,
          notchColor: AppColors.bottomNavItemColor,
          pageController: homeController.pageController,
          bottomBarItems: [
            BottomBarItem(
                itemLabel: 'پروفایل',
                inActiveItem: Icon(Icons.account_box_outlined,
                    color: AppColors.navInactiveItemColor),
                activeItem: Icon(Icons.account_box,
                    color: AppColors.navActiveItemColor)),
            BottomBarItem(
                itemLabel: 'خانه',
                inActiveItem: Icon(
                  Icons.home_outlined,
                  color: AppColors.navInactiveItemColor,
                ),
                activeItem: Icon(Icons.home_filled,
                    color: AppColors.navActiveItemColor)),
            BottomBarItem(
                itemLabel: 'سبد خرید',
                inActiveItem: Icon(Icons.shopping_basket_outlined,
                    color: AppColors.navInactiveItemColor),
                activeItem: Icon(Icons.shopping_basket,
                    color: AppColors.navActiveItemColor)),
          ],
          onTap: (index) {
            homeController.pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
        );
  }
}
