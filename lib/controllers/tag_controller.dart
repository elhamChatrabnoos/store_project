import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/repositories/tag_repository.dart';

import '../models/Tag.dart';

class TagController extends GetxController {

  final TagRepository _tagRepository = TagRepository();
  TextEditingController tagName = TextEditingController();

  // Rx<Tag>? tag;
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
      // this.tag = tag.obs;
      this.tag = tag;
      update();
    });
  }

  void addTag(Tag newTag) {
    _tagRepository.addTag(newTag: newTag).then((value) {
      getTags();
    });
    update();
  }


  Future<void> removeTag(Tag tag) async {
    await _tagRepository.deleteTag(targetTag: tag).then((value){
      getTags();
    });
    update();
  }


  void editTag(Tag tag, int index) {
    _tagRepository.editTag(targetTag: tag).then((value) => getTags());
    update();
  }

  void changeDropDown(Tag selectedTag){
    // print('tag name issssss : ' + selectedTag.name.toString());
    tag = selectedTag;
    update();
  }


}


List<Tag> tagsList = [];
