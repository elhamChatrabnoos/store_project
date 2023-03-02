import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_getx/views/pages/login_page.dart';

import '../../../controllers/user_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_sizes.dart';
import '../../../core/app_texts.dart';
import '../../../models/user.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_image.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  UserController controller = Get.put(UserController());

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
          child: Column(
            children: [
              _exitAccount(),
              AppSizes.littleSizeBox,
              // ProfileImageShape(),
              AppSizes.normalSizeBox2,
              _emailTextField(),
              AppSizes.normalSizeBox2,
              _passwordTextField(),
              AppSizes.normalSizeBox2,
              _phoneNumberTextField(),
              AppSizes.normalSizeBox2,
              _addressTextField(),
              AppSizes.normalSizeBox2,
              _updateUserInfoButton(context),
            ],
          ),
        ));
  }

  Widget _exitAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.exit_to_app),
        AppSizes.littleSizeBoxWidth,
        CustomText(
          text: 'خروج از حساب',
          onClickText: () {
            controller.removeUserFromPref();
            Get.off(LoginPage());
            // Get.to(LoginPage());
          },
        )
      ],
    );
  }

  CustomButton _updateUserInfoButton(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      buttonText: AppTexts.updateAccount,
      buttonColor: AppColors.loginBtnColor,
      onTap: () {
        if (formKey.currentState!.validate()) {
          User user = User(
              userId: controller.getUserFromPref()['userId'],
              userName: controller.userNameController.text,
              userPass: controller.passController.text,
              userAddress: controller.addressController.text,
              userPhone: controller.phoneNumController.text);
          print('user id : ${controller.getUserFromPref()['userId']}');
          print('user name is : ${controller.getUserFromPref()['userName']}');
          controller.editUser(user);
        }
      },
      textSize: AppSizes.normalTextSize2,
    );
  }

  Widget _addressTextField() {
    return CustomTextField(
      initialValue: controller.getUserFromPref()['userAddress'],
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

  Widget _phoneNumberTextField() {
    return CustomTextField(
      initialValue: controller.getUserFromPref()['userPhone'],
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      labelText: AppTexts.phoneTxt,
      checkValidation: (value) {
        if (value!.isNotEmpty && !controller.correctPhoneFormat(value).value) {
          return AppTexts.phoneNumError;
        }
      },
      icon: const Icon(Icons.phone_android),
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _passwordTextField() {
    return Obx(() {
      return CustomTextField(
        initialValue: controller.getUserFromPref()['userPass'],
        labelText: AppTexts.passwordTxt,
        checkValidation: (value) {
          if (!controller.checkPasswordFormat(value!).value) {
            return AppTexts.passwordError;
          }
        },
        icon: const Icon(Icons.remove_red_eye),
        onTapIcon: () => controller.showHidePass(),
        secure: controller.secureTextPass.value,
        borderColor: AppColors.textFieldColor,
      );
    });
  }

  Widget _emailTextField() {
    return CustomTextField(
      initialValue: controller.getUserFromPref()['userName'],
      checkValidation: (value) {
        if (!controller.checkEmailValidation(value!).value) {
          return AppTexts.emailError;
        }
      },
      labelText: AppTexts.emailTxt,
      secure: false,
      onChanged: (value) => controller.checkEmailValidation(value!),
      icon: controller.correctEmail.value
          ? const Icon(Icons.check)
          : const Icon(Icons.email_outlined),
      borderColor: AppColors.textFieldColor,
    );
  }
}
