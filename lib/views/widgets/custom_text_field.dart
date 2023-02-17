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
      required this.borderColor})
      : super(key: key);

  final Function(String?)? onChanged;
  final Function()? onTapIcon;
  final bool? secure;
  final Icon? icon;
  final bool? correctFormat;
  final String? hintText;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? checkValidation;
  final Color? fillColor;
  final Color borderColor;
  FocusNode focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: checkValidation,
      decoration: InputDecoration(
        labelText: hintText ?? '',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        border: InputBorder.none,
        filled: true,
        fillColor: fillColor,
        suffixIcon: InkWell(onTap: onTapIcon, child: icon ?? const SizedBox()),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            )),
      ),
      obscureText: secure ?? false,
    );
  }
}
