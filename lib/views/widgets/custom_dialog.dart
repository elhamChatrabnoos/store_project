import 'package:flutter/material.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/widgets/custom_button.dart';

import 'custom_text.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {Key? key,
      required this.messageTxt,
      required this.onOkTap,
      required this.confirmBtnTxt,
      this.negativeBtnTxt,
      this.onNoTap})
      : super(key: key);

  final String messageTxt;
  final Function() onOkTap;
  final Function()? onNoTap;
  final String confirmBtnTxt;
  final String? negativeBtnTxt;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(text: messageTxt),
          AppSizes.littleSizeBox,
          _rowButtons()
        ],
      ),
    );
  }

  Row _rowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            buttonHeight: 30,
            buttonWidth: 100,
            textSize: 12,
            buttonColor: AppColors.primaryColor,
            textColor: Colors.white,
            buttonText: confirmBtnTxt,
            onTap: onOkTap),
        AppSizes.littleSizeBoxWidth,
        negativeBtnTxt != null
            ? CustomButton(
                buttonHeight: 30,
                buttonWidth: 100,
                textSize: 12,
                buttonColor: AppColors.primaryColor,
                textColor: Colors.white,
                buttonText: negativeBtnTxt!,
                onTap: onNoTap)
            : const SizedBox()
      ],
    );
  }
}
