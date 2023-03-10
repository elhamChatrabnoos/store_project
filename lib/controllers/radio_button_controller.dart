import 'package:get/get.dart';

class RadioBtnController extends GetxController{

  String radioGroupValue = 'پنهان';

  void changeRadioValue(String value){
    radioGroupValue = value;
    update();
  }

}