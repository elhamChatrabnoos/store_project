import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.onChanged,
      this.icon,
      this.correctFormat,
      this.secure,
      this.onTapIcon,
      this.hintText,
      this.initialValue,
      this.inputFormatters,
      this.checkValidation,
      this.fillColor,
      this.borderColor,
      this.labelText,
      this.radius,
      this.keyboardType,
      this.controller})
      : super(key: key);

  final Function(String?)? onChanged;
  final Function()? onTapIcon;
  final bool? secure;
  final Icon? icon;
  final bool? correctFormat;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? checkValidation;
  final Color? fillColor;
  final Color? borderColor;
  final double? radius;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      // focusNode: focusNode,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: checkValidation,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: borderColor ?? AppColors.textFieldColor),
            borderRadius: BorderRadius.circular(radius ?? 15)),
        border: InputBorder.none,
        filled: true,
        fillColor: fillColor,
        suffixIcon: InkWell(onTap: onTapIcon, child: icon ?? const SizedBox()),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.textFieldColor,
              width: 1,
            )),
      ),
      obscureText: secure ?? false,
    );
  }
}
