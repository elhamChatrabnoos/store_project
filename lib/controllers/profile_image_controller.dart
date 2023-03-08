
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ToDo use this class in app
class ProfileImageController extends GetxController{

  File? profileImage;

  Future selectProfileImage(bool fromCamera) async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if(pickedFile != null){
      profileImage = File(pickedFile.path);
    }

    // ImagePicker? pickedFile = ImagePicker();
    // profileImage = pickedFile.pickImage(
    //     source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    update();
  }

  void removeProfileImage() {
    profileImage = null;
    update();
  }


}