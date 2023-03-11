import 'package:get/get.dart';

class RadioBtnController extends GetxController{

  String radioGroupValue = 'خیر';

  void changeRadioValue(String value){
    radioGroupValue = value;
    update();
  }

}