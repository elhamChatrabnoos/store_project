import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_getx/controllers/shopping_cart_controller.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/core/app_texts.dart';
import 'package:shop_getx/models/shopping_cart.dart';
import 'package:shop_getx/repositories/user_repository.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';

import '../models/user.dart';

class UserController extends GetxController {

  RxBool correctEmail = false.obs;
  RxBool secureTextPass = true.obs;
  RxBool secureTextConfPass = true.obs;
  RxBool checkboxValue = false.obs;
  List<User>? userList = [];
  User? currentUser;
  num? newUserId;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final UserRepository _userRepository = UserRepository();
  SharedPreferences? userPref;

  @override
  void onInit() {
    print('init state user controll');
    super.onInit();
    defineSharedPref();
    getUsers();
  }


  Future<void> defineSharedPref() async {
    userPref = await SharedPreferences.getInstance();
    AppSharedPreference.isUserAdminPref = await SharedPreferences.getInstance();
  }


  void saveUserToPref(User user) {
    Map<String, dynamic> userModel = {
      'userId': user.id,
      'userImage': user.userImage,
      'userName': user.userName,
      'userPass': user.userPass,
      'userPhone': user.userPhone,
      'userAddress': user.userAddress,
    };
    userPref!.setString(AppKeys.userPrefKey, jsonEncode(userModel));

    if(user.userName!.contains('Admin')){
      AppSharedPreference.isUserAdminPref!.setBool(AppKeys.isUserAdmin, true);
    }
    else{
      AppSharedPreference.isUserAdminPref!.setBool(AppKeys.isUserAdmin, false);
    }
  }

  Map<String, dynamic> getUserFromPref() {
    print('userPref : $userPref');
    String? user = userPref!.getString(AppKeys.userPrefKey);
    print('user name :::: ${user}');
    return jsonDecode(user!) as Map<String, dynamic>;
  }


  void removeUserFromPref() {
    userPref!.remove(AppKeys.userPrefKey);
  }


  Future<void> addUser(User user) async {
    await _userRepository.addUser(newUser: user).then((value) {
      // ShoppingCart cart = ShoppingCart(userId: value.id, shoppingList: []);
      // shoppingController.addCart(cart);
    });
  }


  void getUsers() {
    _userRepository.getUsers().then((value) {
      userList = value;
    });
  }

  void editUser(User user) {
    _userRepository
        .editUser(targetUser: user, userId: user.id!).then((value) {
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

  bool correctPhoneFormat(String value) {
    return (value.startsWith('0') && value.length == 11);
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
