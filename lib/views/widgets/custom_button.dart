import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      this.buttonColor,
      this.textColor,
      required this.buttonText,
      this.buttonWidth,
      this.onTap})
      : super(key: key);

  final Color? buttonColor;
  final Color? textColor;
  final String buttonText;
  double? buttonWidth;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size.height
    return SizedBox(
        height: MediaQuery.of(context).size.height / 12,
        width: buttonWidth ?? MediaQuery.of(context).size.width,
        child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: buttonColor ?? Colors.white,
              side: const BorderSide(width: 1, color: Colors.blueAccent),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: 18),
            )));
  }
}
