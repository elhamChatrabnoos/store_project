import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/pages/bottom_navigation_pages/home_page.dart';
import '../views/pages/user_info_page.dart';
import '../views/pages/bottom_navigation_pages/shopping_cart_page.dart';

class MainPageController extends GetxController{
  List bottomBarPages = [UserProfilePage(), HomePage(), ShoppingCartPage()];
  PageController pageController = PageController(initialPage: 1);
}