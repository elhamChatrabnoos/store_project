import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/pages/home_page_related/home_page.dart';
import '../views/pages/home_page_related/shop_basket_page.dart';
import '../views/pages/home_page_related/user_info_page.dart';

class HomeController extends GetxController{

  RxInt _selectedNavIndex = 1.obs;

  List _bottomBarPages = [
    const ShopBasketPage(),
    const HomePage(),
    const UserInfoPage(),
  ];

  final pageController = PageController(initialPage: 1);
  int maxCount = 3;

  void onTappedNavItem(int index){
    _selectedNavIndex.value = index;
  }

  List get bottomBarPages => _bottomBarPages;

  set bottomBarPages(List value) {
    _bottomBarPages = value;
  }

  RxInt get selectedNavIndex => _selectedNavIndex;

  set selectedNavIndex(RxInt value) {
    _selectedNavIndex = value;
  }
}