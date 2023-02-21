import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key,
    required this.text,
    this.textSize,
    this.textWeight,
    this.textColor,
    this.textDecoration,
    this.decorationColor,
    this.textAlign})
      : super(key: key);

  final String text;
  final double? textSize;
  final FontWeight? textWeight;
  final Color? textColor;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: textColor,
          fontWeight: textWeight ?? FontWeight.bold,
          decoration: textDecoration,
          decorationColor: decorationColor,
          fontSize: textSize),
    );
  }
}
