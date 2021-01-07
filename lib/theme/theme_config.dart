import 'package:flutter/material.dart';

class ThemeConfig {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff1f1f1f);

  static Color lightAccent = Color(0xff2B2825);
  static Color darkAccent = Color(0xffF8EBAA);

  static Color lightBG = Color(0xFFEAEAEA);
  static Color darkBG = Color(0xff2B2825);

  static Color darkBottom = Colors.white;
  static Color lightBottom = Colors.black;

  static Color selectedIcon = Color(0xffF8EBAA);
  static Color selectedIconLight = Colors.white;

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    bottomAppBarColor: lightBottom,
    scaffoldBackgroundColor: lightBG,
    selectedRowColor: selectedIconLight,
    appBarTheme: AppBarTheme(
      elevation: 5.0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    bottomAppBarColor: darkBottom,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    selectedRowColor: selectedIcon,
    appBarTheme: AppBarTheme(
      elevation: 5.0,
    ),
  );
}
