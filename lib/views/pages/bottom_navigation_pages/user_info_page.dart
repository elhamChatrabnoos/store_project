import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/loign_sign_up_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_sizes.dart';
import '../../../core/app_texts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_image.dart';

class UserInfoPage extends StatelessWidget {
   UserInfoPage({Key? key}) : super(key: key);

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
              AppSizes.littleSizeBox,
              ProfileImageShape(),
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

  CustomButton _updateUserInfoButton(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      buttonText: AppTexts.updateAccount,
      buttonColor: AppColors.loginBtnColor,
      onTap: () {
        if (formKey.currentState!.validate()) {

        }
      },
      textSize: AppSizes.normalTextSize2,
    );
  }

  Widget _phoneNumberTextField() {
    return CustomTextField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      labelText: AppTexts.phoneTxt,
      checkValidation: (value) {
        if (!value!.startsWith('0') && value.length < 11) {
          return AppTexts.phoneNumError;
        }
      },
      icon: const Icon(Icons.phone_android),
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _passwordTextField() {
    return CustomTextField(
      labelText: AppTexts.passwordTxt,
      checkValidation: (value) {
        if (!loginSignupController.checkPasswordFormat(value!).value) {
          return AppTexts.passwordError;
        }
      },
      icon: const Icon(Icons.remove_red_eye),
      onTapIcon: () => loginSignupController.showHidePass(),
      secure: loginSignupController.secureTextPass.value,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _emailTextField() {
    return CustomTextField(
      checkValidation: (value) {
        if (!loginSignupController.checkEmailValidation(value!).value) {
          return AppTexts.emailError;
        }
      },
      labelText: AppTexts.emailTxt,
      secure: false,
      onChanged: (value) => loginSignupController.checkEmailValidation(value!),
      icon: loginSignupController.correctEmail.value
          ? const Icon(Icons.check)
          : const Icon(Icons.email_outlined),
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _addressTextField() {
    return CustomTextField(
      checkValidation: (value) {
        if (value!.length < 10) {
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
