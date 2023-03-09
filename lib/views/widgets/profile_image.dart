import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

class ProfileImageShape extends StatelessWidget {
  ProfileImageShape(
      {Key? key,
      this.tapOnCamera,
      this.imageFile,
      this.tapOnGallery,
      this.tapOnDelete})
      : super(key: key);

  final Function()? tapOnCamera;
  final Function()? tapOnGallery;
  final Function()? tapOnDelete;
  final Future<Uint8List?>? imageFile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                      textSize: AppSizes.subTitleTextSize),
                  AppSizes.normalSizeBox2,
                  Row(
                    children: [
                      AppSizes.normalSizeBoxWidth2,
                      _option(tapOnCamera, context, 'دوربین', Icons.camera_alt),
                      AppSizes.normalSizeBoxWidth2,
                      _option(tapOnGallery, context, 'گالری', Icons.folder),
                      AppSizes.normalSizeBoxWidth2,
                      _option(tapOnDelete, context, 'حذف', Icons.delete),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: _profileAvatar(150),
    );
  }

  Widget _option(Function()? onTapIcon, BuildContext context, String subTitle,
      IconData iconData) {
    return InkWell(
      onTap: onTapIcon,
      child: Column(
        children: [
          Icon(iconData, color: AppColors.primaryColor, size: 30),
          CustomText(
            text: subTitle,
            textSize: AppSizes.normalTextSize1,
          )
        ],
      ),
    );
  }

  Widget _profileAvatar(double imageSize) {
    print(imageFile);
    if (imageFile == null) {
      return CircleAvatar(
        radius: 60,
        child: ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Image.asset('assets/images/userImage.png',
              width: imageSize, height: imageSize),
        ),
      );
    } else {
      return FutureBuilder(
        future: imageFile,
        builder: (context, snapshot) {
          return Image.memory(snapshot.data!, width: 200, height: 100);
        });
      // return CircleAvatar(
      //     backgroundColor: AppColors.grayColor,
      //     radius: 60,
      //     child: ClipOval(
      //         child: kIsWeb
      //             ? Image.network(imageFile!.path,
      //                 width: imageSize, height: imageSize)
      //             : Image.file(File(imageFile!.path),
      //                 width: imageSize, height: imageSize)));
    }
  }
}
