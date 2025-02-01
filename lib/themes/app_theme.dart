import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/themes/app_bar_theme.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';


class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Almarai",
      primaryColor: lightPrimarily1Color,
      scaffoldBackgroundColor: lightBackgroundColor,
      iconTheme: const IconThemeData(color: lightPrimarily1Color),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: lightPrimarily1Color, fontSize: 16),
        headlineLarge: TextStyle(color: lightPrimarily2Color, fontSize: 30, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: lightPrimarily2Color, fontSize: 20, fontWeight: FontWeight.bold),
        labelLarge: TextStyle(color: lightThird11Color, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      textButtonTheme: lightTextButtonThemeData,
      iconButtonTheme: lightIconButtonThemeData,
      appBarTheme: lightAppBarThemeData
    );
  }

    static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Almarai",
      primaryColor: darkPrimarily1Color,
      scaffoldBackgroundColor: darkBackgroundColor,
      iconTheme: const IconThemeData(color: darkPrimarily1Color),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: darkPrimarily1Color, fontSize: 16),
        headlineLarge: TextStyle(color: darkPrimarily2Color, fontSize: 30, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: darkPrimarily2Color, fontSize: 20, fontWeight: FontWeight.bold),
        labelLarge: TextStyle(color: darkThird11Color, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      textButtonTheme: darkTextButtonThemeData,
      iconButtonTheme: darkIconButtonThemeData,
      appBarTheme: darkAppBarThemeData
    );
  }
}
