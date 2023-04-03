import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/repositories/tag_repository.dart';

import '../../models/Tag.dart';

class TagController extends GetxController {

  final TagRepository _tagRepository = TagRepository();
  TextEditingController tagNameController = TextEditingController();

  Tag? tag;

  @override
  void onInit() {
    super.onInit();
    getTags();
  }

  Future<void> getTags() async {
    await _tagRepository.getTags().then((value) {
      tagsList = value;

      Tag tag = Tag(id: 0, name: LocaleKeys.Add_product_page_withoutTag.tr);
      tagsList.add(tag);
      this.tag = tag;

      update();
    });
  }


  Future<void> addTag(Tag newTag) async {
    await _tagRepository.addTag(newTag: newTag);
    update();
  }


  Future<void> removeTag(Tag tag) async {
    await _tagRepository.deleteTag(targetTag: tag).then((value) {
      getTags();
    });
    update();
  }

  Future<void> editTag(Tag tag, int index) async {
    await _tagRepository.editTag(targetTag: tag);
    update();
  }


  void changeDropDown(Tag selectedTag) {
    tag = selectedTag;
    update();
  }

}

List<Tag> tagsList = [];
