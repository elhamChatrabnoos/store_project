import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/core/app_sizes.dart';

import '../../controllers/profile_image_controller.dart';
import '../../controllers/user_controller.dart';
import '../../core/app_colors.dart';
import '../../core/app_texts.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/profile_image.dart';


class AddProductPage extends GetView {
  AddProductPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  // ProfileImageController profileController = Get.put(ProfileImageController());
  // ProfileImageController profileController = Get.find<ProfileImageController>();


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ProfileImageController());
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('افزودن محصول جدید'),
          ),
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
              child: Column(
                children: [
                _productImage(context),
                AppSizes.normalSizeBox3,
                _textField(AppTexts.productName, false),
                AppSizes.normalSizeBox3,
                _textField(AppTexts.productDescription, false),
                AppSizes.normalSizeBox3,
                _textField(AppTexts.productPrice, true),
                AppSizes.normalSizeBox3,
                _textField(AppTexts.productDiscount, true),
                AppSizes.normalSizeBox3,
                // _createAccountButton(context, logic),
                ],
              )
          ),
        ));
  }

  Widget _productImage(BuildContext context) {
    return GetBuilder<ProfileImageController>(
      assignId: true,
      builder: (logic) {
        return ProfileImageShape(
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
          imageFile: logic.profileImage,
        );
      },
    );
  }

  Widget _createAccountButton(BuildContext context, ProductController logic) {
    return CustomButton(
      textColor: Colors.white,
      buttonText: AppTexts.createAccountBtn,
      buttonColor: AppColors.loginBtnColor,
      onTap: () {
        // if (formKey.currentState!.validate()) {
        //   if (logic.checkUserNameExist(logic.userNameController.text)) {
        //     Get.snackbar('کاربر تکراری', 'نام کاربری موجود است.');
        //   } else {
        //     // prepare user image and information
        //     User user = User(
        //         userName: logic.userNameController.text,
        //         userPass: logic.passController.text,
        //         userAddress: logic.addressController.text,
        //         userPhone: logic.phoneNumController.text);
        //
        //     logic.addUser(user);
        //     // Get.off(LoginPage());
        //   }
        // }
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
        if (value!.isNotEmpty && !logic.correctPhoneFormat(value)) {
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

  Widget _textField(String text, bool isNumberField) {
    return CustomTextField(
      checkValidation: (value) {
        if (value!.isEmpty) {
          return AppTexts.emailError;
        }
      },
      // inputFormatters: [isNumberField  ? FilteringTextInputFormatter.digitsOnly : ]  ,
      labelText: text,
      // onChanged: (value) => logic.checkEmailValidation(value!),
      borderColor: AppColors.textFieldColor,
    );
  }

  // Widget _productDescription() {
  //   return CustomTextField(
  //     checkValidation: (value) {
  //       if (value!.isEmpty) {
  //         return AppTexts.emailError;
  //       }
  //     },
  //     inputFormatters: [isNumberField  ? FilteringTextInputFormatter.digitsOnly : ]  ,
  //     labelText: text,
  //     // onChanged: (value) => logic.checkEmailValidation(value!),
  //     borderColor: AppColors.textFieldColor,
  //   );
  // }

  // Widget _productPrice() {
  //   return CustomTextField(
  //     checkValidation: (value) {
  //       if (value!.isEmpty) {
  //         return AppTexts.emailError;
  //       }
  //     },
  //     inputFormatters: [isNumberField  ? FilteringTextInputFormatter.digitsOnly : ]  ,
  //     labelText: text,
  //     // onChanged: (value) => logic.checkEmailValidation(value!),
  //     borderColor: AppColors.textFieldColor,
  //   );
  // }
  //
  // Widget _productDiscount() {
  //   return CustomTextField(
  //     checkValidation: (value) {
  //       if (value!.isEmpty) {
  //         return AppTexts.emailError;
  //       }
  //     },
  //     inputFormatters: [isNumberField  ? FilteringTextInputFormatter.digitsOnly : ]  ,
  //     labelText: text,
  //     // onChanged: (value) => logic.checkEmailValidation(value!),
  //     borderColor: AppColors.textFieldColor,
  //   );
  // }

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
