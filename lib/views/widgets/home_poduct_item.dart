import 'package:flutter/material.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';

class ProductItem extends StatelessWidget {
  ProductItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      this.discount})
      : super(key: key);

  String title;
  String description;
  int price;
  final int? discount;
  String image;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _productImage(),
              const SizedBox(height: 10),
              CustomText(text: title, textSize: 17),
              _descriptionText(),
              const SizedBox(height: 5),
              discount != null ? _productDiscount() : const SizedBox(),
              _priceText()
            ],
          ),
        ));
  }

  CustomText _descriptionText() {
    return CustomText(
              text: description,
              textSize: 13,
              textWeight: FontWeight.normal,
              textColor: Colors.deepPurple,
            );
  }

  CustomText _priceText() {
    return CustomText(
        text: discount != null
            ? '${price - price * discount! ~/ 100} تومان '
            : '$price تومان ',
        textSize: 15);
  }

  Row _productDiscount() {
    return Row(
      children: [
        Container(
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomText(
                  text: '$discount%',
                  textSize: 14,
                  textWeight: FontWeight.bold,
                  textColor: Colors.white,
                ))),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(
              text: price.toString(),
              textDecoration: TextDecoration.lineThrough,
              decorationColor: const Color.fromARGB(255, 0, 0, 0),
              textSize: 14,
              textColor: const Color.fromARGB(255, 140, 140, 140)),
        ),
      ],
    );
  }

  Align _productImage() {
    return Align(
        alignment: Alignment.center,
        child: Image.asset(
          image,
          width: 100,
          height: 100,
        ));
  }
}
