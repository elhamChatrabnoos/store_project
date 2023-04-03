import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_line_field_package/multi_line_field_package.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/models/user.dart';

import '../../controllers/shared/image_controller.dart';
import '../../controllers/client/user_controller.dart';
import '../../core/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/image_picker.dart';
import 'login_page.dart';

class SignUpPage extends GetView<ImageController> {
  SignUpPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: _bodyOfPage(context));
  }

  Padding _bodyOfPage(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 10),
        child: Form(
          key: formKey,
          // Todo delete thumb and show keyboard and textField together
          child: SingleChildScrollView(
              child: Column(
            children: [
              AppSizes.littleSizeBox,
              CustomText(
                  text: LocaleKeys.SignUp_page_signUpTitle.tr, textSize: 30),
              AppSizes.littleSizeBox,
              _profileImage(context),
              AppSizes.normalSizeBox2,
              GetBuilder<UserController>(builder: (logic) {
                return Column(
                  children: [
                    _emailTextField(logic),
                    AppSizes.normalSizeBox2,
                    _passwordTextField(logic),
                    AppSizes.normalSizeBox2,
                    _phoneNumberTextField(logic),
                    AppSizes.normalSizeBox2,
                    _addressTextField(logic),
                    AppSizes.normalSizeBox2,
                    _createAccountButton(context, logic),
                    AppSizes.normalSizeBox2,
                    _haveAccount()
                  ],
                );
              })
            ],
          )),
        ));
  }

  CustomText _haveAccount() {
    return CustomText(
        textDecoration: TextDecoration.underline,
        text: LocaleKeys.SignUp_page_haveAccount.tr,
        onClickText: () => Get.off(LoginPage()),
        textColor: Colors.blue);
  }

  Widget _profileImage(BuildContext context) {
    return GetBuilder<ImageController>(
      assignId: true,
      builder: (logic) {
        return ImagePicker(
          tapOnGallery: () {
            logic.selectProfileImage(false);
            Navigator.pop(context);
          },
          tapOnCamera: () {
            logic.selectProfileImage(true);
            Navigator.pop(context);
          },
          tapOnDelete: () {
            logic.removeProfileImage();
            Navigator.pop(context);
          },
          imageFile: logic.imageFile != null
              ? logic.stringToImage(logic.imageFile)
              : null,
        );
      },
    );
  }

  Widget _createAccountButton(BuildContext context, UserController logic) {
    return CustomButton(
      textColor: Colors.white,
      buttonText: LocaleKeys.Login_page_signUpBtn.tr,
      buttonColor: AppColors.loginBtnColor,
      buttonHeight: MediaQuery.of(context).size.height / 12,
      buttonWidth: MediaQuery.of(context).size.width,
      onTap: () {
        if (formKey.currentState!.validate()) {
          if (logic.checkUserNameExist(logic.userNameController.text)) {
            Get.snackbar(LocaleKeys.SignUp_page_repeatedUser.tr,
                LocaleKeys.SignUp_page_availableUserMessage.tr);
          } else {
            // prepare user image and information
            User user = User(
                userImage: controller.imageFile,
                userName: logic.userNameController.text,
                userPass: logic.passController.text,
                userAddress: logic.addressController.text,
                userPhone: logic.phoneNumController.text);

            logic.addUser(user);
            Get.off(() => LoginPage());
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
      labelText: LocaleKeys.SignUp_page_phoneNumber.tr,
      checkValidation: (value) {
        if (value!.isNotEmpty && !logic.correctPhoneFormat(value)) {
          return LocaleKeys.SignUp_page_phoneNumError.tr;
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
        labelText: LocaleKeys.SignUp_page_password.tr,
        checkValidation: (value) {
          if (!logic.checkPasswordFormat(value!).value) {
            return LocaleKeys.SignUp_page_passwordError.tr;
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
        if (!logic.checkEmailValidation(value!).value) {
          return LocaleKeys.SignUp_page_emailError.tr;
        }
      },
      labelText: LocaleKeys.SignUp_page_userName.tr,
      secure: false,
      icon: const Icon(Icons.email_outlined),
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _addressTextField(UserController logic) {
    return MultiLineField(
      maxLines: 5,
      controller: logic.addressController,
      validation: (value) {
        if (value!.isNotEmpty && !(value.length >= 10)) {
          return LocaleKeys.SignUp_page_addressError.tr;
        }
      },
      labelText: LocaleKeys.SignUp_page_address.tr,
      suffixIcon: const Icon(Icons.home),
      borderColor: AppColors.textFieldColor,
    );
  }
}
