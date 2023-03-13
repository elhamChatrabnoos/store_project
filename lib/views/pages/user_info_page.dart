import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_line_field_package/multi_line_field_package.dart';
import 'package:shop_getx/controllers/image_controller.dart';
import 'package:shop_getx/views/pages/login_page.dart';

import '../../controllers/user_controller.dart';
import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../core/app_texts.dart';
import '../../models/user.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    controller.userNameController.text =
    UserController.getUserFromPref()['userName'];
    controller.passController.text =
    UserController.getUserFromPref()['userPass'];
    controller.addressController.text =
    UserController.getUserFromPref()['userAddress'];
    controller.phoneNumController.text =
    UserController.getUserFromPref()['userPhone'];
  }

  // ToDo it has error when come from sign up page
  final formKey = GlobalKey<FormState>();
  UserController controller = Get.find<UserController>();
  ImageController imageController = Get.put(ImageController());

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

  Widget _bodyOfPage(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding:
          const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AppSizes.littleSizeBox,
                _userImage(),
                AppSizes.normalSizeBox2,
                _userNameTextField(),
                AppSizes.normalSizeBox2,
                _passwordTextField(),
                AppSizes.normalSizeBox2,
                _phoneNumberTextField(),
                AppSizes.normalSizeBox2,
                _addressTextField(),
                AppSizes.normalSizeBox2,
                _buttons(),
              ],
            ),
          )),
    );
  }

  Widget _buttons() {
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
              userImage: imageController.imageFile,
              userName: controller.userNameController.text,
              userPass: controller.passController.text,
              userAddress: controller.addressController.text,
              userPhone: controller.phoneNumController.text);

          controller.editUser(user).then((value) {
            Get.snackbar(AppTexts.updateAccount, AppTexts.userEditedSuccessful);
          });
        }
      },
    );
  }

  Widget _addressTextField() {
    return  MultiLineField(
      maxLines: 5,
      controller: controller.addressController,
      validation: (value) {
        if (value!.isNotEmpty && !(value.length >= 10)) {
          return AppTexts.addressError;
        }
      },
      labelText: AppTexts.addressTxt,
      borderColor: AppColors.textFieldColor,
      suffixIcon: const Icon(Icons.home),
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
      secure: false,
    );
  }

  Widget _passwordTextField() {
    return Obx(() {
      return CustomTextField(
        controller: controller.passController,
        labelText: AppTexts.passwordTxt,
        checkValidation: (value) {
          if (!controller
              .checkPasswordFormat(value!)
              .value) {
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
          if (!controller
              .checkEmailValidation(value!)
              .value) {
            return AppTexts.emailError;
          }
        },
        labelText: AppTexts.emailTxt,
        secure: false,
        icon: const Icon(Icons.email_outlined),
        borderColor: AppColors.textFieldColor,
      );
  }

  Widget _userImage() {
    return GetBuilder<ImageController>(
      initState: (state) {
        if (UserController.getUserFromPref()['userImage'] != null) {
          imageController.imageFile =
          UserController.getUserFromPref()['userImage'];
        }
      },
      assignId: true,
      builder: (controller) {
        return ImagePicker(
          tapOnGallery: () {
            controller.selectProfileImage(false);
            Navigator.pop(context);
          },
          tapOnCamera: () {
            controller.selectProfileImage(true);
            Navigator.pop(context);
          },
          tapOnDelete: () {
            controller.removeProfileImage();
            Navigator.pop(context);
          },
          imageFile: controller.imageFile != null
              ? controller.stringToImage(controller.imageFile)
              : null,
        );
      },
    );
  }
}
