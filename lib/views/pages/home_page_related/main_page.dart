import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_getx/controllers/home_page_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/views/pages/home_page_related/home_page.dart';
import 'package:shop_getx/views/pages/home_page_related/shop_basket_page.dart';
import 'package:shop_getx/views/pages/home_page_related/user_info_page.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: homeController.pageController,
        physics: const NeverScrollableScrollPhysics(),
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
                color: Colors.lightGreen,
                showLabel: false,
                notchColor: Colors.greenAccent,
                pageController: homeController.pageController,
                bottomBarItems: const [
                  BottomBarItem(
                      itemLabel: 'پروفایل',
                      inActiveItem: Icon(Icons.account_box_outlined),
                      activeItem: Icon(Icons.account_box)),
                  BottomBarItem(
                      itemLabel: 'خانه',
                      inActiveItem: Icon(Icons.home_outlined),
                      activeItem: Icon(Icons.home_filled)),
                  BottomBarItem(
                      itemLabel: 'سبد خرید',
                      inActiveItem: Icon(Icons.shopping_basket_outlined),
                      activeItem: Icon(Icons.shopping_basket)),
                ],
               onTap: (index) {
                  print(index);
                 homeController.pageController.animateToPage(index,
                     duration: const Duration(milliseconds: 500),
                     curve: Curves.bounceInOut);
               },
              );
  }
}
