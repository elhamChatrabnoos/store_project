import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/models/user.dart';

import '../../controllers/loign_sign_up_controller.dart';
import '../../core/app_colors.dart';
import '../../core/app_texts.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/profile_image.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final UserController loginController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: _bodyOfPage(context)));
  }

  Padding _bodyOfPage(BuildContext context) {
    return Padding(
        padding:
        const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 10),
        child: Form(
          key: formKey,
          // Todo delete thumb and show keyboard and textField together
          child: SingleChildScrollView(
            child: GetBuilder<UserController>(
              assignId: true,
              builder: (logic) {
                return Column(
                  children: [
                    AppSizes.littleSizeBox,
                    CustomText(text: AppTexts.createAccountBtn, textSize: 30),
                    AppSizes.littleSizeBox,
                    ProfileImageShape(),
                    AppSizes.normalSizeBox2,
                    _emailTextField(logic),
                    AppSizes.normalSizeBox2,
                    _passwordTextField(logic),
                    AppSizes.normalSizeBox2,
                    _phoneNumberTextField(logic),
                    AppSizes.normalSizeBox2,
                    _addressTextField(logic),
                    AppSizes.normalSizeBox2,
                    _createAccountButton(context, logic),
                  ],
                );
              },
            ),
          ),
        ));
  }

  Widget _createAccountButton(BuildContext context, UserController logic) {
    return CustomButton(
      textColor: Colors.white,
      buttonText: AppTexts.createAccountBtn,
      buttonColor: AppColors.loginBtnColor,
      onTap: () {
        if (formKey.currentState!.validate()) {
          User user = User(
              userName: logic.userNameController.text,
              userPass: logic.passController.text,
              userAddress: logic.addressController.text,
              userPhone: logic.phoneNumController.text);

          if (logic.userExist(user)) {
            Get.snackbar('کاربر تکراری', 'نام کاربری موجود است.');
          }
          else {
            logic.addUser(user);
            Get.to(LoginPage());
          }
        }
      },
      textSize: AppSizes.normalTextSize2,
    );
  }

  Widget _phoneNumberTextField(UserController logic) {
    return CustomTextField(
      controller: logic.phoneNumController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      labelText: AppTexts.phoneTxt,
      checkValidation: (value) {
        if (value!.isNotEmpty &&
            !(value.startsWith('0') && value.length < 11)) {
          return AppTexts.phoneNumError;
        }
      },
      icon: const Icon(Icons.phone_android),
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _passwordTextField(UserController logic) {
    return Obx(() {
      return CustomTextField(
        controller: logic.passController,
        labelText: AppTexts.passwordTxt,
        checkValidation: (value) {
          if (!logic
              .checkPasswordFormat(value!)
              .value) {
            return AppTexts.passwordError;
          }
        },
        icon: const Icon(Icons.remove_red_eye),
        onTapIcon: () => logic.showHidePass(),
        secure: logic.secureTextPass.value,
        borderColor: AppColors.textFieldColor,
      );
    });
  }

  Widget _emailTextField(UserController logic) {
    return CustomTextField(
      controller: logic.userNameController,
      checkValidation: (value) {
        if (!logic
            .checkEmailValidation(value!)
            .value) {
          return AppTexts.emailError;
        }
      },
      labelText: AppTexts.emailTxt,
      secure: false,
      onChanged: (value) => logic.checkEmailValidation(value!),
      icon: logic.correctEmail.value
          ? const Icon(Icons.check)
          : const Icon(Icons.email_outlined),
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _addressTextField(UserController logic) {
    return CustomTextField(
      controller: logic.addressController,
      checkValidation: (value) {
        if (value!.isNotEmpty && !(value.length >= 10)) {
          return AppTexts.addressError;
        }
      },
      labelText: AppTexts.addressTxt,
      secure: false,
      icon: const Icon(Icons.home),
      borderColor: AppColors.textFieldColor,
    );
  }
}
