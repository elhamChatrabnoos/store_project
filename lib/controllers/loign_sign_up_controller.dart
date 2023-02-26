
import 'package:get/get.dart';

class LoginSignupController extends GetxController{
  RxBool _correctEmail = false.obs;
  RxBool _secureTextPass = true.obs;
  RxBool _secureTextConfPass = true.obs;
  RxBool _checkboxValue = false.obs;
  RxString _registeredEmail = ''.obs;
  RxString _registeredPassword = ''.obs;
  RxBool _checkedAgreement = false.obs;

  RxBool checkInformation(String email, String password) {
    return (email == registeredEmail).obs;
    // && password == _registeredPassword;
  }

  RxBool checkEmailValidation(String value) {
    _correctEmail =
    ((value.contains('@gmail.com') || value.contains('@yahoo.com'))
        ? true
        : false).obs;
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
    _registeredPassword.value = samePass ? firstInput : '';
    return samePass.obs;
  }

  void showHidePass() {
    secureTextPass.value = secureTextPass.value ? false : true;
  }

  void showHideConfPass() {
    _secureTextConfPass.value = _secureTextConfPass.value ? false : true;
  }


  RxBool checkAgreement(bool value){
    _checkedAgreement.value = value;
    return _checkedAgreement;
  }

  RxBool get checkedAgreement => _checkedAgreement;

  set checkedAgreement(RxBool value) {
    _checkedAgreement = value;
  }

  RxString get registeredPassword => _registeredPassword;

  set registeredPassword(RxString value) {
    _registeredPassword = value;
  }

  RxString get registeredEmail => _registeredEmail;

  set registeredEmail(RxString value) {
    _registeredEmail = value;
  }

  RxBool get checkboxValue => _checkboxValue;

  set checkboxValue(RxBool value) {
    _checkboxValue = value;
  }

  RxBool get secureTextConfPass => _secureTextConfPass;

  set secureTextConfPass(RxBool value) {
    _secureTextConfPass = value;
  }

  RxBool get secureTextPass => _secureTextPass;

  set secureTextPass(RxBool value) {
    _secureTextPass = value;
  }

  RxBool get correctEmail => _correctEmail;

  set correctEmail(RxBool value) {
    _correctEmail = value;
  }
}