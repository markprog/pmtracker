import 'package:flutter/material.dart';

import '../constants/AppColors.dart';

class Themes {

  static const TextTheme textTheme = TextTheme(
      // Large text bold from design
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColor.white,
        fontSize: 20,
      ),
      // Large text regular from design
      headlineMedium: TextStyle(fontWeight: FontWeight.w400, color: AppColor.white, fontSize: 20, height: 30,),
      // Medium text bold from design
      titleLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColor.white,
      ),
      // Medium text bold from design
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: AppColor.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColor.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColor.white,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(fontSize: 18, color: AppColor.white),
  );


  static ThemeData defaultTheme = ThemeData(
    appBarTheme: AppBarTheme(color: AppColor.dark2, titleTextStyle: textTheme.headlineLarge),
    scaffoldBackgroundColor: AppColor.dark2,
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.darkBlue),)),
  );
}
