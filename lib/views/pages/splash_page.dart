import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

import '../../controllers/favorites_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../shared_class/shared_prefrences.dart';
import 'login_page.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {

  UserController userController = Get.put(UserController());
  final ProductController productController = Get.put(ProductController());
  ShoppingCartController shoppingController = Get.put(ShoppingCartController());
  FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  void initState() {
    _specifyPage();
    super.initState();
  }

  void _specifyPage() {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      AppSharedPreference.userPref!.getString('user') != null
          ? Get.off(() => MainPage())
      : Get.off(() => LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/shop_image.png',
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
          CustomText(
            text: 'مونس مارکت',
            textColor: AppColors.primaryColor,
            textSize: AppSizes.normalTextSize1,
          ),
        ],
      ),
    );
  }
}
