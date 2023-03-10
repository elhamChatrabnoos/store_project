import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  final Future<Uint8List?>? categoryImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _itemImage(),
          Text(text),
          showEdit ? _addDeleteIcons() : const SizedBox(),
        ],
      ),
    );
  }

  Widget _itemImage() {
    if(categoryImage == null){
      return Image.asset('assets/images/shop_image.png', width: 100, height: 100);
    }
    else{
      return FutureBuilder(
        future: categoryImage,
        builder: (context, snapshot) {
          return Image.memory(snapshot.data!, width: 100, height: 100);
        },);
    }

  }

  Row _addDeleteIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onEditClick,
          icon: Icon(Icons.edit, size: 20,),
        ),
        IconButton(
          onPressed: onDeleteClick,
          icon: Icon(Icons.delete, size: 20,),
        ),
      ],
    );
  }
}
