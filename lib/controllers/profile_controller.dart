
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  // File imageFile = File('file.txt');

  Future selectImage(bool fromCamera, File? imageFile) async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    update();
  }


}