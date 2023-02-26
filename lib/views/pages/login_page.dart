import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/loign_sign_up_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_images.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/pages/sign_up_page.dart';

import '../../core/app_texts.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'main_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final LoginSignupController loginSignupController =
      Get.put(LoginSignupController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: _loginBody(context)));
  }

  Widget _loginBody(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          textSize: AppSizes.buttonsTextSize,
          buttonWidth: 150,
          textColor: AppColors.loginTextColor,
          buttonText: AppTexts.loginBtnTxt,
          buttonColor: AppColors.loginBtnColor,
          onTap: () {
            if (formKey.currentState!.validate()) {
              Get.to(MainPage());
            }
          },
        ),
        CustomButton(
            textSize: AppSizes.buttonsTextSize,
            buttonWidth: 150,
            textColor: AppColors.loginBtnColor,
            buttonText: AppTexts.signUpBtnTxt,
            buttonColor: AppColors.loginTextColor,
            onTap: () => Get.to(SignUpPage())),
      ],
    );
  }

  Widget _passwordTextField() {
    return Obx(() {
      return CustomTextField(
        borderColor: AppColors.textFieldColor,
        labelText: AppTexts.passwordTxt,
        checkValidation: (value) {
          if (value!.isEmpty) {
            return AppTexts.incorrectPassMsg;
          }
        },
        icon: const Icon(Icons.remove_red_eye),
        onTapIcon: () => loginSignupController.showHidePass(),
        secure: loginSignupController.secureTextPass.value,
      );
    });
  }

  Widget _emailTextField() {
    return CustomTextField(
      borderColor: AppColors.textFieldColor,
      labelText: AppTexts.emailTxt,
      checkValidation: (value) {
        if (value!.isEmpty) {
          return AppTexts.unavailableEmailMsg;
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
        Image.asset(AppImages.loginImage, alignment: Alignment.center),
      ],
    ));
  }
}
