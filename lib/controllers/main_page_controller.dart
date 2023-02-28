import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/pages/bottom_navigation_pages/home_page.dart';
import '../views/pages/bottom_navigation_pages/buy_basket_page.dart';
import '../views/pages/bottom_navigation_pages/user_info_page.dart';


class MainController extends GetxController{

  List _bottomBarPages = [
    UserInfoPage(),
    HomePage(),
    ShopBasketPage(),
  ];

  final pageController = PageController(initialPage: 1);


  int maxCount = 3;

  List get bottomBarPages => _bottomBarPages;

  set bottomBarPages(List value) {
    _bottomBarPages = value;
  }

}