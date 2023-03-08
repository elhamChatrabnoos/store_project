import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {Key? key,
      required this.text,
      this.onTapItem,
      required this.showEdit,
      required this.onEditClick,
      required this.onDeleteClick})
      : super(key: key);

  final String text;
  final Function()? onTapItem;
  final bool showEdit;
  final Function() onEditClick;
  final Function() onDeleteClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/shop_image.png',
            width: 100,
            height: 50,
          ),
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
          icon: Icon(Icons.edit),
        ),
        IconButton(
          onPressed: onDeleteClick,
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
