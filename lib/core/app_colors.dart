import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{

  static Color textFieldColor = const Color.fromARGB(255, 152, 152, 187);
  static Color backColor = const Color.fromARGB(255, 215, 215, 215);
  static Color darkGrayColor = const Color.fromARGB(255, 150, 146, 146);
  static Color loginBtnColor = const Color.fromARGB(255, 26, 24, 68);
  static Color loginTextColor = const Color.fromARGB(255, 255, 255, 255);
  static Color bottomNavBackColor = const Color.fromARGB(255, 169, 169, 169);
  static Color bottomNavItemColor = const Color.fromARGB(255, 193, 193, 206);
  static Color navActiveItemColor = const Color.fromARGB(255, 0, 0, 0);
  static Color navInactiveItemColor = const Color.fromARGB(255, 93, 90, 90);
  static Color backGroundColor = const Color.fromARGB(255, 250, 250, 250);
  static Color grayColor = const Color.fromARGB(255, 232, 232, 232);
  static Color grayColor2 = const Color.fromARGB(255, 210, 207, 207);

  static Color buttonColor = const Color(0xFF5CC2FA);
  static Color deepButtonColor = const Color(0xFF044C72);
  static Color subTextColor = Colors.deepPurple;

  static  MaterialColor primaryColor = MaterialColor(
    const Color.fromARGB(255, 26, 24, 68).value, <int, Color>{
      50: Colors.white.withOpacity(1),
      100: Colors.white.withOpacity(0.2),
      200: Colors.white.withOpacity(0.3),
      300: Colors.white.withOpacity(0.4),
      400: Colors.white.withOpacity(0.5),
      500: Colors.white.withOpacity(0.6),
      600: Colors.white.withOpacity(0.7),
      700: Colors.white.withOpacity(0.8),
      800: Colors.white.withOpacity(0.9),
      900: Colors.white.withOpacity(1),
    },
  );
}