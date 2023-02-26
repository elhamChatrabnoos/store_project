import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{

  static Color textFieldColor = const Color.fromARGB(255, 152, 152, 187);
  static Color backColor = const Color.fromARGB(255, 215, 215, 215);
  static Color loginBtnColor = const Color.fromARGB(255, 26, 24, 68);
  static Color loginTextColor = const Color.fromARGB(255, 255, 255, 255);
  static Color bottomNavBackColor = const Color.fromARGB(255, 174, 172, 208);
  static Color bottomNavItemColor = const Color.fromARGB(255, 193, 193, 206);
  static Color navActiveItemColor = const Color.fromARGB(255, 0, 0, 0);
  static Color navInactiveItemColor = const Color.fromARGB(255, 93, 90, 90);

  static Color buttonColor = const Color(0xFF5CC2FA);
  static Color deepButtonColor = const Color(0xFF044C72);
  static Color subTextColor = Colors.deepPurple;



  static  MaterialColor primaryColor = MaterialColor(
    const Color.fromARGB(255, 255, 255, 255).value, <int, Color>{
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