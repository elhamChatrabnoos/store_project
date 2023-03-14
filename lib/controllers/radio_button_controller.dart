import 'package:get/get.dart';

import '../generated/locales.g.dart';

class RadioBtnController extends GetxController{

  String radioGroupValue = LocaleKeys.Add_product_page_noBtn.tr;

  void changeRadioValue(String value){
    radioGroupValue = value;
    update();
  }

}