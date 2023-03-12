import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/tag_controller.dart';
import 'package:shop_getx/views/pages/main_page.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import '../../models/Tag.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

// class AddEditTagDialog extends GetView<TagController> {
class AddEditTagDialog extends StatelessWidget {
  AddEditTagDialog(
      {Key? key, required this.isActionEdit, this.targetTag, this.tagIndex})
      : super(key: key);

  final formKey = GlobalKey<FormState>();
  final bool isActionEdit;
  final Tag? targetTag;
  final int? tagIndex;

  // TagController tagController = Get.find<TagController>();
  TagController tagController = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => TagController());
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: tagController.tagName,
              checkValidation: (value) {
                if (value!.isEmpty) {
                  return 'نام تگ نمیتواند خالی باشد.';
                }
              },
              labelText: 'نام تگ',
              borderColor: AppColors.textFieldColor,
            ),
            AppSizes.normalSizeBox3,
            CustomButton(
              buttonWidth: 100,
              buttonHeight: 40,
              textColor: Colors.white,
              buttonText: isActionEdit ? 'ویرایش' : 'ذخیره',
              buttonColor: AppColors.loginBtnColor,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  !isActionEdit ? _addTag() : _editCategory();
                  Get.back();
                }
              },
              textSize: AppSizes.normalTextSize1,
            )
          ],
        ),
      ),
    );
  }

  void _addTag() {
    Tag tag = Tag( name: tagController.tagName.text);
    tagController.addTag(tag);
  }

  void _editCategory() {
    Tag tag = Tag(id: targetTag!.id, name: tagController.tagName.text);
    tagController.editTag(tag, tagIndex!);
  }


}
