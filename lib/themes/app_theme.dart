import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/themes/app_bar_theme.dart';
import 'package:mtaa_frontend/themes/buttom_bar_theme.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Almarai",
      primaryColor: lightPrimarily1Color,
      secondaryHeaderColor: lightBackground1Color,
      scaffoldBackgroundColor: lightBackgroundColor,
      iconTheme: const IconThemeData(color: lightPrimarily1Color),
      colorScheme: const ColorScheme.light(
        primary: lightThird3Color,
        secondary: lightThird2Color,
        tertiary: lightThird1Color,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: lightPrimarily1Color, fontSize: 16),
        bodySmall: TextStyle(color: lightPrimarily2Color, fontSize: 10),
        displaySmall: TextStyle(color: primarily0InvincibleColor, fontSize: 8),
        headlineLarge: TextStyle(color: lightPrimarily2Color, fontSize: 30, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: lightPrimarily2Color, fontSize: 20, fontWeight: FontWeight.bold),
        labelSmall: TextStyle(color: lightThird1Color, fontSize: 16, fontWeight: FontWeight.normal),
        labelLarge: TextStyle(color: lightThird11Color, fontSize: 30, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(color: primarily0InvincibleColor, fontSize: 20, fontWeight: FontWeight.normal, decorationColor: secondary1InvincibleColor),
        titleMedium: TextStyle(color: secondary1InvincibleColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      textButtonTheme: lightTextButtonThemeData,
      iconButtonTheme: lightIconButtonThemeData,
      appBarTheme: lightAppBarThemeData,
      bottomAppBarTheme: lightBottomBarThemeData,
      floatingActionButtonTheme: lightfloatingActionButtonThemeData,
      timePickerTheme: TimePickerThemeData(
        backgroundColor: whiteColor,
        hourMinuteTextColor: secondary1InvincibleColor,
        dialHandColor: lightThird11Color,
        entryModeIconColor: secondary1InvincibleColor,
        dayPeriodTextColor: lightThird11Color,
        dayPeriodBorderSide: BorderSide(color: whiteColor),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Almarai",
      primaryColor: darkPrimarily1Color,
      secondaryHeaderColor: darkBackground1Color,
      scaffoldBackgroundColor: darkBackgroundColor,
      iconTheme: const IconThemeData(color: darkPrimarily1Color),
      colorScheme: const ColorScheme.dark(
        primary: darkThird3Color,
        secondary: darkThird2Color,
        tertiary: darkThird1Color,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: darkPrimarily1Color, fontSize: 16),
        bodySmall: TextStyle(color: darkPrimarily2Color, fontSize: 10),
        displaySmall: TextStyle(color: darkPrimarily1Color, fontSize: 8),
        headlineLarge: TextStyle(color: darkPrimarily2Color, fontSize: 30, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: darkPrimarily2Color, fontSize: 20, fontWeight: FontWeight.bold),
        labelSmall: TextStyle(color: darkThird1Color, fontSize: 16, fontWeight: FontWeight.normal),
        labelLarge: TextStyle(color: darkThird11Color, fontSize: 30, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(color: primarily0InvincibleColor, fontSize: 20, fontWeight: FontWeight.normal, decorationColor: secondary1InvincibleColor),
        titleMedium: TextStyle(color: secondary1InvincibleColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      textButtonTheme: darkTextButtonThemeData,
      iconButtonTheme: darkIconButtonThemeData,
      appBarTheme: darkAppBarThemeData,
      bottomAppBarTheme: darkBottomBarThemeData,
      floatingActionButtonTheme: darkfloatingActionButtonThemeData,
      timePickerTheme: TimePickerThemeData(
        backgroundColor: whiteColor,
        hourMinuteTextColor: secondary1InvincibleColor,
        dialHandColor: Colors.lightGreenAccent,
        entryModeIconColor: secondary1InvincibleColor,
        dayPeriodTextColor: lightThird11Color,
        dayPeriodBorderSide: BorderSide(color: whiteColor)
      ),
    );
  }

  static ThemeData inclusiveTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: "Almarai",
    primaryColor: Colors.black,
    secondaryHeaderColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.blueAccent,
      tertiary: Colors.deepOrangeAccent,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black, fontSize: 22),
      bodySmall: TextStyle(color: Colors.black, fontSize: 16),
      displaySmall: TextStyle(color: Colors.black, fontSize: 14),
      headlineLarge: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.normal),
      titleMedium: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
    ),
    textButtonTheme: specialTextButtonThemeData,
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white, size: 28),
      titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.black,
      surfaceTintColor: Colors.black,
      elevation: 0,
      height: 100,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}

}
