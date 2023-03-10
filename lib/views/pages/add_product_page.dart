import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/radio_button_controller.dart';
import 'package:shop_getx/controllers/tag_controller.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

import '../../controllers/image_controller.dart';
import '../../controllers/user_controller.dart';
import '../../core/app_colors.dart';
import '../../core/app_texts.dart';
import '../../models/Tag.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/profile_image.dart';

class AddProductPage extends GetView<ImageController> {
  AddProductPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  TagController tagController = Get.find<TagController>();
  RadioBtnController radioController = Get.put(RadioBtnController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
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
                  _productDescription(AppTexts.productDescription),
                  AppSizes.normalSizeBox3,
                  _productPrice(AppTexts.productPrice),
                  AppSizes.normalSizeBox3,
                  _productDiscount(AppTexts.productDiscount),
                  AppSizes.normalSizeBox3,
                  _productTotalCount(AppTexts.totalProductCount),
                  AppSizes.normalSizeBox3,
                  _productTag(context, AppTexts.productTag),
                  AppSizes.normalSizeBox3,
                  _isProductHide(),
                  _saveButton(context),
                ],
              )),
        ));
  }

  Widget _productImage(BuildContext context) {
    return GetBuilder<ImageController>(
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
          imageFile: controller.imageFile != null
              ? controller.stringToImage(controller.imageFile)
              : null,
        );
      },
    );
  }

  Widget _saveButton(BuildContext context) {
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

  Widget _textField(String text, bool isNumberField) {
    return CustomTextField(
      checkValidation: (value) {
        if (value!.isEmpty) {
          return AppTexts.emailError;
        }
      },
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productDescription(String text) {
    return CustomTextField(
      checkValidation: (value) {
        if (value!.isEmpty) {
          return AppTexts.emailError;
        }
      },
      maxLines: 5,
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productPrice(String text) {
    return CustomTextField(
      checkValidation: (value) {
        if (value!.isEmpty) {
          return AppTexts.emailError;
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productDiscount(String text) {
    return CustomTextField(
      checkValidation: (value) {
        if (value!.isEmpty) {
          return AppTexts.emailError;
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }

  Widget _productTotalCount(String text) {
    return CustomTextField(
      checkValidation: (value) {
        if (value!.isEmpty) {
          return AppTexts.emailError;
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: text,
      borderColor: AppColors.textFieldColor,
    );
  }


  Widget _productTag(BuildContext context, String text) {
    return Container(
        color: AppColors.grayColor,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: GetBuilder<TagController>(
              assignId: true,
              builder: (logic) {
                return DropdownButton<Tag>(
                  hint: Text(text),
                  // if any term click to edit disable this button
                  onChanged: (Tag? value) {
                    tagController.changeDropDown(value!);
                  },
                  value: tagController.tag,
                  items: tagsList.map((Tag item) {
                    return DropdownMenuItem<Tag>(
                        value: item, child: Text(item.name!));
                  }).toList(),
                );
              },
            ),
          ),
        ));
  }


  Widget _isProductHide() {
    return GetBuilder<RadioBtnController>(
      assignId: true,
      builder: (logic) {
        return Row(
          children: [
            CustomText(text: 'محصول پنهان باشد؟'),
            ListTile(
              title: const Text('بله'),
              leading: Radio<String>(
                value: 'بله',
                groupValue: radioController.radioGroupValue,
                onChanged: (value) {
                  radioController.changeRadioValue(value.toString());
                },
              ),
            ),

            ListTile(
              title: const Text('خیر'),
              leading: Radio<String>(
                value: 'خیر',
                groupValue: radioController.radioGroupValue,
                onChanged: (value) {
                  radioController.changeRadioValue(value.toString());
                },
              ),
            ),
            // RadioListTile(
            //   title: Text('بله'),
            //   value: 'بله',
            //   groupValue: radioController.radioGroupValue,
            //   onChanged: (value) {
            //     radioController.changeRadioValue(value.toString());
            //   },
            // ),
            //
            // RadioListTile(
            //   title: Text('خیر'),
            //   value: 'خیر',
            //   groupValue: radioController.radioGroupValue,
            //   onChanged: (value) {
            //     radioController.changeRadioValue(value.toString());
            //   },
            // ),
          ],
        );
      },
    );
  }

}
