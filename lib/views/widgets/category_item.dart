import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/image_controller.dart';
import 'future_image.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {Key? key,
      required this.text,
      this.onTapItem,
      required this.showEdit,
      required this.onEditClick,
      required this.onDeleteClick,
      required this.categoryImage})
      : super(key: key);

  final String text;
  final Function()? onTapItem;
  final bool showEdit;
  final Function() onEditClick;
  final Function() onDeleteClick;
  final String categoryImage;

  ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureImage(
              future: imageController.stringToImage(categoryImage),
              imageSize: 100),
          Text(text),
          showEdit ? _addDeleteIcons() : const SizedBox(),
        ],
      ),
    );
  }

  Row _addDeleteIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onEditClick,
          icon: const Icon(
            Icons.edit,
            size: 20,
          ),
        ),
        IconButton(
          onPressed: onDeleteClick,
          icon: const Icon(
            Icons.delete,
            size: 20,
          ),
        ),
      ],
    );
  }
}
