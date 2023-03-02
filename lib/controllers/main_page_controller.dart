import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/pages/bottom_navigation_pages/home_page.dart';
import '../views/pages/bottom_navigation_pages/buy_basket_page.dart';
import '../views/pages/bottom_navigation_pages/profile_page.dart';


class MainController extends GetxController{

  List bottomBarPages = [
    UserProfilePage(),
    HomePage(),
    ShopBasketPage(),
  ];

  final pageController = PageController(initialPage: 1);

  int maxCount = 3;

}