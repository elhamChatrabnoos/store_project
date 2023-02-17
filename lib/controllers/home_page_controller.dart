import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/pages/home_page_related/home_page.dart';
import '../views/pages/home_page_related/shop_basket_page.dart';
import '../views/pages/home_page_related/user_info_page.dart';

class HomeController extends GetxController{

  List _bottomBarPages = [
    const UserInfoPage(),
    HomePage(),
    const ShopBasketPage(),
  ];

  final pageController = PageController(initialPage: 1);
  int maxCount = 3;

  List get bottomBarPages => _bottomBarPages;

  set bottomBarPages(List value) {
    _bottomBarPages = value;
  }

}