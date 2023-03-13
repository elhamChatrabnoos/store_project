import 'package:flutter/material.dart';

class MultiLineField extends StatelessWidget {
  const MultiLineField(
      {Key? key,
        this.controller,
        this.validation,
        this.labelText,
        this.borderColor,
        this.fillColor,
        this.maxLines,
        this.suffixIcon})
      : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? labelText;
  final Color? borderColor;
  final Color? fillColor;
  final int? maxLines;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: validation,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: borderColor ?? const Color.fromARGB(255, 152, 152, 187)),
            borderRadius: BorderRadius.circular(15)),
        border: InputBorder.none,
        filled: true,
        fillColor: fillColor,
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Color.fromARGB(190, 255, 0, 0)),
            borderRadius: BorderRadius.circular(15)),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColor ?? const Color.fromARGB(255, 152, 152, 187),
              width: 1,
            )),
      ),
    );
  }
}