import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/views/pages/main_page_related/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppColors.primaryColor,
        ),
        home: MainPage()
        // Directionality(textDirection: TextDirection.rtl, child: MainPage()),
        );
  }
}
