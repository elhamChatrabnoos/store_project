import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/category_controller.dart';
import 'package:shop_getx/repositories/tag_repository.dart';

import '../models/Tag.dart';

class TagController extends GetxController {
  final TagRepository _tagRepository = TagRepository();
  TextEditingController tagName = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTags();
  }

  void getTags() {
    _tagRepository.getTags().then((value) {
      tagsList = value;
    });
  }

  void addTag(Tag newTag) {
    _tagRepository.addTag(newTag: newTag).then((value) {
      getTags();
    });
    tagsList.add(newTag);
    update();
  }

  void removeTag(Tag tag) {
    _tagRepository.deleteTag(targetTag: tag).then((value) => getTags());
    tagsList.remove(tag);
    update();
  }

  void editTag(Tag tag, int index) {
    _tagRepository.editTag(targetTag: tag).then((value) {
      getTags();
    });
    tagsList[index] = tag;
    update();
  }
}

List<Tag> tagsList = [];
