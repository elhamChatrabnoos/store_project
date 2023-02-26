
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  Rx<File>? imageFile;

  Future selectImage(bool fromCamera) async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = Rx<File>(File(pickedFile.path)).obs as Rx<File>?;
    }
  }


}