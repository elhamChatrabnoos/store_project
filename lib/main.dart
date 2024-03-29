import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/views/pages/add_edit_product_page.dart';
import 'package:shop_getx/views/pages/main_page.dart';
import 'package:shop_getx/views/pages/splash_page.dart';

import 'generated/locales.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scrollBehavior: const MaterialScrollBehavior()
            .copyWith(scrollbars: false),
        // locale: const Locale('fa_IR'),
      // locale: const Locale('en_Us'),
      locale: const Locale('fa', 'IR'),
      translationsKeys: AppTranslation.translations,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppColors.primaryColor,
        ),
        home: const SplashPage()
        );
  }
}
