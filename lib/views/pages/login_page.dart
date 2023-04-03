import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/client/favorites_controller.dart';
import 'package:shop_getx/controllers/client/shopping_cart_controller.dart';
import 'package:shop_getx/controllers/client/user_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_images.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/models/shopping_cart.dart';
import 'package:shop_getx/views/pages/sign_up_page.dart';

import '../../core/app_keys.dart';
import '../../models/favorites.dart';
import '../../shared_class/shared_prefrences.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    userController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: _loginBody(context));
  }

  Widget _loginBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _titleTextImage(),
                AppSizes.normalSizeBox,
                _emailTextField(),
                AppSizes.normalSizeBox2,
                _passwordTextField(),
                AppSizes.normalSizeBox,
                _buttons(context)
              ],
            ),
          )),
    );
  }

  Widget _buttons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          textSize: AppSizes.normalTextSize2,
          buttonWidth: size.width / 3,
          buttonHeight: size.height / 12,
          textColor: AppColors.loginTextColor,
          buttonText: LocaleKeys.Login_page_loginBtn.tr,
          buttonColor: AppColors.loginBtnColor,
          onTap: () {
            if (formKey.currentState!.validate()) {
              userController.saveUserToPref(userController.currentUser!);

              UserController.isUserAdmin = AppSharedPreference.isUserAdminPref!
                  .getBool(AppKeys.isUserAdmin)!;

              if (!UserController.isUserAdmin!) {
                _findShoppingCart();
                _findFavoriteList();
              }

              Get.off(() => MainPage());
            }
          },
        ),
        CustomButton(
            textSize: AppSizes.normalTextSize2,
            buttonHeight: MediaQuery.of(context).size.height / 12,
            buttonWidth: MediaQuery.of(context).size.width / 3,
            textColor: AppColors.loginBtnColor,
            buttonText: LocaleKeys.Login_page_signUpBtn.tr,
            buttonColor: AppColors.loginTextColor,
            onTap: () => Get.off(SignUpPage())),
      ],
    );
  }

  void _findShoppingCart() {
    ShoppingCartController shoppingController =
        Get.put(ShoppingCartController());
    if (!shoppingController
        .searchUserShoppingCart(userController.currentUser!.id!)) {
      ShoppingCart cart = ShoppingCart(
          userId: userController.currentUser!.id, shoppingList: []);
      shoppingController.addShoppingCart(cart);
    }
  }

  void _findFavoriteList() {
    FavoritesController favoritesController = Get.put(FavoritesController());
    if (!favoritesController
        .searchUserInFavorites(userController.currentUser!.id!)) {
      Favorite favorite =
          Favorite(userId: userController.currentUser!.id, favoritesList: []);
      favoritesController.addFavorite(favorite);
    }
  }

  Widget _passwordTextField() {
    return Obx(() {
      return CustomTextField(
        controller: userController.passController,
        borderColor: AppColors.textFieldColor,
        labelText: LocaleKeys.Login_page_password.tr,
        checkValidation: (value) {
          if (value!.isEmpty ||
              !userController.userExist(userController.userNameController.text,
                  userController.passController.text)) {
            return LocaleKeys.Login_page_incorrectPassError.tr;
          }
        },
        icon: const Icon(Icons.remove_red_eye),
        onTapIcon: () => userController.showHidePass(),
        secure: userController.secureTextPass.value,
      );
    });
  }

  Widget _emailTextField() {
    return CustomTextField(
      controller: userController.userNameController,
      borderColor: AppColors.textFieldColor,
      labelText: LocaleKeys.Login_page_userName.tr,
      checkValidation: (value) {
        if (value!.isEmpty ||
            !userController
                .checkUserNameExist(userController.userNameController.text)) {
          return LocaleKeys.Login_page_unavailableEmailError.tr;
        }
      },
      secure: false,
      icon: const Icon(Icons.account_circle),
    );
  }

  Widget _titleTextImage() {
    return Center(
        child: Column(
      children: [
        AppSizes.littleSizeBox,
        Image.asset(AppImages.loginImage,
            width: 200, height: 200, alignment: Alignment.center),
      ],
    ));
  }
}
