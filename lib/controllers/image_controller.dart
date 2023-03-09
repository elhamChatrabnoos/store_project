import 'dart:convert';

import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ToDo use this class in app
class ImageController extends GetxController {
  String? imageFile;

  void selectProfileImage(bool fromCamera) async {
    ImagePicker pickedFile = ImagePicker();
    XFile? selectedImageFile = await pickedFile.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    // if (profileImageFile != null) {
    //   imageAsString = imageToString(profileImageFile);
    // }
    imageFile = await imageToString(selectedImageFile!);
    update();
  }

  void removeProfileImage() {
    imageFile = null;
    update();
  }

  Future<String>? imageToString(XFile image) async {
    Uint8List imgByte = await image.readAsBytes();
    return base64.encode(imgByte);
  }

  Future<Uint8List?> stringToImage(String? imageString) async {
    if (imageString != null) {
      return await base64.decode(imageString);
    }
    return null;
  }


}
