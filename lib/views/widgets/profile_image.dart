import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_getx/controllers/profile_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

class ProfileImageShape extends StatelessWidget {
  ProfileImageShape({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                            text: 'انتخاب پروفایل',
                            textSize: AppSizes.subTitleTextSize2),
                        AppSizes.normalSizeBox2,
                        Row(
                          children: [
                            AppSizes.normalSizeBoxWidth2,
                            _option(context, 'دوربین', Icons.camera_alt),
                            AppSizes.normalSizeBoxWidth2,
                            _option(context, 'گالری', Icons.folder),
                            AppSizes.normalSizeBoxWidth2,
                            _option(context, 'حذف', Icons.delete),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: _profileAvatar(100)));
  }

  Widget _option(BuildContext context, String subTitle, IconData iconData) {
    return InkWell(
      onTap: () {
        if (subTitle == 'دوربین') {
          profileController.selectImage(true);
        } else if (subTitle == 'گالری') {
          profileController.selectImage(false);
        } else {
          profileController.imageFile = null;
        }
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Icon(iconData, color: AppColors.primaryColor, size: 30),
          CustomText(
            text: subTitle,
            textSize: AppSizes.subTitleTextSize,
          )
        ],
      ),
    );
  }

  // _selectImage(bool fromCamera) async {
  //   PickedFile? pickedFile = await ImagePicker.platform.pickImage(
  //       source: fromCamera ? ImageSource.camera : ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //   }
  // }

  Widget _profileAvatar(double imageSize) {
    return profileController.imageFile == null
        ? Image.asset('assets/images/userImage.png',
            width: imageSize, height: imageSize)
        : Obx(() {
            return Image.file(
              width: imageSize,
              height: imageSize,
              profileController.imageFile!.value,
              fit: BoxFit.cover,
            );
          });
  }
}
