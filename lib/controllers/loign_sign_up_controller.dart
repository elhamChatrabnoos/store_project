import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_getx/repositories/user_repository.dart';

import '../models/user.dart';

class UserController extends GetxController {

  RxBool _correctEmail = false.obs;
  RxBool secureTextPass = true.obs;
  RxBool _secureTextConfPass = true.obs;
  RxBool _checkboxValue = false.obs;
  List<User>? userList;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final UserRepository _userRepository = UserRepository();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void addUser(User user) {
    _userRepository.addUser(newUser: user);
  }

  void getUser(){
    _userRepository.getUsers().then((value) {
      userList = value;
    });
  }


  bool userExist(User user){
    // search user in userList before add
    for (var userElement in userList!) {
      if(userElement.userName == user.userName){
        return true;
      }
    }
   return false;
  }

  RxBool checkEmailValidation(String value) {
    _correctEmail =
        ((value.contains('@gmail.com') || value.contains('@yahoo.com'))
            ? true.obs
            : false.obs);
    update();
    return _correctEmail;
  }

  RxBool checkPasswordFormat(String inputValue) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(inputValue).obs;
  }

  RxBool checkConfirmPass(String? firstInput, String secondInput) {
    bool samePass = firstInput == secondInput && firstInput!.isNotEmpty;
    // _registeredPassword.value = samePass ? firstInput : '';
    return samePass.obs;
  }

  void showHidePass() {
    secureTextPass.value = secureTextPass.value ? false : true;
  }

  void showHideConfPass() {
    _secureTextConfPass.value = _secureTextConfPass.value ? false : true;
  }

  RxBool get checkboxValue => _checkboxValue;

  set checkboxValue(RxBool value) {
    _checkboxValue = value;
  }

  RxBool get secureTextConfPass => _secureTextConfPass;

  set secureTextConfPass(RxBool value) {
    _secureTextConfPass = value;
  }


  RxBool get correctEmail => _correctEmail;

  set correctEmail(RxBool value) {
    _correctEmail = value;
  }
}
