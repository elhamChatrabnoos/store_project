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
import 'home_page_related/main_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();

  final LoginSignupController loginSignupController =
  Get.put(LoginSignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: loginBody(context));
  }

  Widget loginBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleTextImage(),
              AppSizes.normalSizeBox,
              AppSizes.littleSizeBox,
              emailTextField(),
              AppSizes.normalSizeBox2,
              AppSizes.littleSizeBox,
              passwordTextField(),
              AppSizes.normalSizeBox,
              buttons(context)
            ],
          ),
        ));
  }

  Widget buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          buttonWidth: 150,
          textColor: AppColors.loginTextColor,
          buttonText: AppTexts.loginBtnTxt,
          buttonColor: AppColors.loginBtnColor,
          onTap: () {
            if (formKey.currentState!.validate()) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }
          },
        ),
        CustomButton(
          buttonWidth: 150,
          textColor: AppColors.loginBtnColor,
          buttonText: AppTexts.signUpBtnTxt,
          buttonColor: AppColors.loginTextColor,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
        )
      ],
    );
  }

  Widget passwordTextField() {
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
        onTapIcon: () {
          loginSignupController.showHidePass();
        },
        secure: loginSignupController.secureTextPass.value,
      );
    });
  }

  Widget emailTextField() {
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

  Center titleTextImage() {
    return Center(
        child: Column(
          children: [
            AppSizes.littleSizeBox,
            Image.asset(AppImages.loginImage, alignment: Alignment.center),
          ],
        ));
  }
}
