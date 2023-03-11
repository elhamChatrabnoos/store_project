import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_getx/repositories/tag_repository.dart';

import '../models/Tag.dart';

class TagController extends GetxController {

  final TagRepository _tagRepository = TagRepository();
  TextEditingController tagName = TextEditingController();

  Tag? tag ;

  @override
  void onInit() {
    super.onInit();
    print('init state in controller : ');
    getTags();
  }

  void getTags() {
    _tagRepository.getTags().then((value) {
      tagsList = value;
      tag = tagsList.first;
      update();
    });
  }

  void addTag(Tag newTag) {
    _tagRepository.addTag(newTag: newTag).then((value) {
      getTags();
    });
    update();
  }

  void removeTag(Tag tag) {
    _tagRepository.deleteTag(targetTag: tag).then((value) => getTags());
    update();
  }

  void editTag(Tag tag, int index) {
    _tagRepository.editTag(targetTag: tag).then((value) => getTags());
    update();
  }

  void changeDropDown(Tag selectedTag){
    tag = selectedTag;
    update();
  }


}


List<Tag> tagsList = [];
