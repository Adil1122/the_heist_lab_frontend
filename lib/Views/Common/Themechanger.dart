import 'package:flutter/material.dart';
import 'package:new_ui/Constants/app_constants.dart';

final ThemeData lightTheme = ThemeData(
  shadowColor: kDark,

  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFC9C9C9),
  primaryColor: kOrange,
  disabledColor: Color(0xFFC9C9C9),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE2E2E2),
    iconTheme: IconThemeData(color: kDark),
    titleTextStyle: TextStyle(color: kDark, fontSize: 20),
    shadowColor: Color(0xFF2E2E2E),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: kDark),
    bodyMedium: TextStyle(color: kDark),
  ),
  colorScheme: ColorScheme.light(
    primary: kOrange,
    onPrimary: kLight,
    surface: Color(0xFFC9C9C9),
    onSurface: kDark,
  ),
);

final ThemeData darkTheme = ThemeData(
  shadowColor: kLight,

  brightness: Brightness.dark,
  scaffoldBackgroundColor: kdark2,
  primaryColor: kOrange,

  disabledColor: Color(0xFF2E2E2E),
  appBarTheme: const AppBarTheme(
    backgroundColor: kDark,
    iconTheme: IconThemeData(color: kLight),
    titleTextStyle: TextStyle(color: kLight, fontSize: 20),
    shadowColor: Color(0xFFC9C9C9),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: kLight),
    bodyMedium: TextStyle(color: kLight),
  ),
  colorScheme: ColorScheme.dark(
    primary: kOrange,
    onPrimary: kDark,
    surface: kDarkGrey,
    onSurface: kLight,
  ),
);
