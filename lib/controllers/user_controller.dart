import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_getx/repositories/user_repository.dart';

import '../models/user.dart';

class UserController extends GetxController {
  RxBool correctEmail = false.obs;
  RxBool secureTextPass = true.obs;
  RxBool secureTextConfPass = true.obs;
  RxBool checkboxValue = false.obs;
  List<User>? userList;
  User? currentUser;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final UserRepository _userRepository = UserRepository();
  SharedPreferences? userPref;

  @override
  void onInit() {
    super.onInit();
    defineSharedPref();
    getUsers();
  }

  Future<void> defineSharedPref() async {
    userPref = await SharedPreferences.getInstance();
  }

  void saveUserToPref(User user) {
    Map<String, dynamic> userModel = {
      'userId': user.userId,
      'userName': user.userName!,
      'userPass': user.userPass,
      'userPhone': user.userPhone!,
      'userAddress': user.userAddress!,
    };
    userPref!.setString('user', jsonEncode(userModel));
  }

  Map<String, dynamic> getUserFromPref() {
    String? user = userPref!.getString('user');
    return jsonDecode(user!) as Map<String, dynamic>;
  }

  void removeUserFromPref() {
    userPref!.remove('user');
  }

  void addUser(User user) {
    _userRepository.addUser(newUser: user);
  }

  void getUsers() {
    _userRepository.getUsers().then((value) {
      userList = value;
    });
  }

  void editUser(User user) {
    _userRepository
        .editUser(targetUser: user, userId: user.userId!)
        .then((value) {
      print('userUpdated');
    });
    saveUserToPref(user);
  }

  bool userExist(String userName, String pass) {
    if (checkUserNameExist(userName)) {
      if (currentUser!.userPass == pass) {
        return true;
      }
    }
    return false;
  }

  bool checkUserNameExist(String userName) {
    for (var userElement in userList!) {
      print('userName: ${userElement.userName}');
      print('id: ${userElement.userId}');
      print('address: ${userElement.userAddress}');
      print('phone: ${userElement.userPhone}');
      print('pass: ${userElement.userPass}');
    }
    // search user in userList before add
    for (var userElement in userList!) {
      if (userElement.userName == userName) {
        currentUser = userElement;
        return true;
      }
    }
    return false;
  }

  RxBool checkEmailValidation(String value) {
    correctEmail =
        ((value.contains('@gmail.com') || value.contains('@yahoo.com'))
            ? true.obs
            : false.obs);
    update();
    return correctEmail;
  }

  RxBool checkPasswordFormat(String inputValue) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(inputValue).obs;
  }

  RxBool correctPhoneFormat(String value){
    return (value.startsWith('0') && value.length <= 11).obs;
  }

  void showHidePass() {
    secureTextPass.value = secureTextPass.value ? false : true;
  }

  void showHideConfPass() {
    secureTextConfPass.value = secureTextConfPass.value ? false : true;
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passController.dispose();
    phoneNumController.dispose();
    addressController.dispose();
  }
}
