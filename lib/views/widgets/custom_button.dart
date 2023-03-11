import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      this.buttonColor,
      this.textColor,
      required this.buttonText,
      this.buttonWidth,
      this.buttonHeight,
      this.onTap, this.textSize,
        this.borderColor})
      : super(key: key);

  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final String buttonText;
  final double? textSize;
  double? buttonWidth;
  double? buttonHeight;
  final Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: buttonHeight,
        width: buttonWidth,
        child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: buttonColor ?? Colors.white,
              side:  BorderSide(width: 1, color: borderColor ?? Colors.blueAccent),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: textSize ?? 14),
            )));
  }
}
