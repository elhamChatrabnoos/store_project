import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key,
    required this.text,
    this.textSize,
    this.textWeight,
    this.textColor,
    this.textDecoration,
    this.decorationColor,
    this.textAlign, this.overflow, this.onClickText})
      : super(key: key);

  final String text;
  final double? textSize;
  final FontWeight? textWeight;
  final Color? textColor;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Function()? onClickText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickText,
      child: Text(
        text,
        maxLines: 1,
        overflow: overflow,
        style: TextStyle(
            color: textColor,
            fontWeight: textWeight ?? FontWeight.bold,
            decoration: textDecoration,
            decorationColor: decorationColor,
            fontSize: textSize),
      ),
    );
  }
}
