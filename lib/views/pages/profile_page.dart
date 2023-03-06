import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_getx/views/pages/login_page.dart';

import '../../controllers/user_controller.dart';
import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../core/app_texts.dart';
import '../../models/user.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/profile_image.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  @override
  void initState() {
    super.initState();
    controller.userNameController.text = UserController.getUserFromPref()['userName'];
    controller.passController.text = UserController.getUserFromPref()['userPass'];
    controller.addressController.text = UserController.getUserFromPref()['userAddress'];
    controller.phoneNumController.text = UserController.getUserFromPref()['userPhone'];
  }

  // ToDo it has error when come from sign up page
  final formKey = GlobalKey<FormState>();
  UserController controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
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
              _userNameTextField(),
              AppSizes.normalSizeBox2,
              _passwordTextField(),
              AppSizes.normalSizeBox2,
              _phoneNumberTextField(),
              AppSizes.normalSizeBox2,
              _addressTextField(),
              AppSizes.normalSizeBox2,
              _exitAccount(),
            ],
          ),
        ));
  }

  Widget _exitAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _updateUserInfoButton(context),
        AppSizes.normalSizeBoxWidth2,
        CustomText(
          textColor: Colors.blue,
          text: 'خروج از حساب',
          onClickText: () {
            controller.removeUserFromPref();
            Get.offAll(() => LoginPage());
          },
        ),
      ],
    );
  }

  Widget _updateUserInfoButton(BuildContext context) {
    return CustomText(
      textColor: Colors.blue,
      text: AppTexts.updateAccount,
      onClickText: () {
        if (formKey.currentState!.validate()) {
          User user = User(
              id: UserController.getUserFromPref()['userId'],
              userName: controller.userNameController.text,
              userPass: controller.passController.text,
              userAddress: controller.addressController.text,
              userPhone: controller.phoneNumController.text);
          controller.editUser(user);
          Get.snackbar(AppTexts.updateAccount, AppTexts.userEditedSuccessful);
        }
      },
    );
  }

  Widget _addressTextField() {
    return CustomTextField(
      controller: controller.addressController,
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
      controller: controller.phoneNumController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      labelText: AppTexts.phoneTxt,
      checkValidation: (value) {
        if (value!.isNotEmpty && !controller.correctPhoneFormat(value)) {
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
        controller: controller.passController,
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

  Widget _userNameTextField() {
    return CustomTextField(
      controller: controller.userNameController,
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


