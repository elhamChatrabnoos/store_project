import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/tag_controller.dart';
import 'package:shop_getx/generated/locales.g.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../models/Tag.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class AddEditTagDialog extends StatelessWidget {
  AddEditTagDialog(
      {Key? key, required this.isActionEdit, this.targetTag, this.tagIndex})
      : super(key: key);

  final formKey = GlobalKey<FormState>();
  final bool isActionEdit;
  final Tag? targetTag;
  final int? tagIndex;

  TagController controller = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    if(isActionEdit){
      controller.tagNameController.text = targetTag!.name!;
    }
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: controller.tagNameController,
              checkValidation: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.HomePage_tagNameError.tr;
                }
              },
              labelText: LocaleKeys.HomePage_tagName.tr,
              borderColor: AppColors.textFieldColor,
            ),
            AppSizes.normalSizeBox3,
            GetBuilder<TagController>(
              assignId: true,
              builder: (logic) {
                return CustomButton(
                  buttonWidth: 100,
                  buttonHeight: 40,
                  textColor: Colors.white,
                  buttonText: isActionEdit
                      ? LocaleKeys.Dialogs_message_editBtn.tr
                      : LocaleKeys.Dialogs_message_saveBtn.tr,
                  buttonColor: AppColors.loginBtnColor,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      !isActionEdit ? _addTag() : _editCategory();
                    }
                  },
                  textSize: AppSizes.normalTextSize1,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _addTag() async {
    Tag tag = Tag(name: controller.tagNameController.text);
    await controller.addTag(tag);
    Get.back();
  }

  Future<void> _editCategory() async {
    Tag tag = Tag(
        id: targetTag!.id, name: controller.tagNameController.text);
    await controller.editTag(tag, tagIndex!);
    Get.back();
  }

}
