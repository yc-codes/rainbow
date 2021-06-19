import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Inter',
    snackBarTheme: SnackBarThemeData(
      elevation: 1,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(0),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all<Size>(Size.zero),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
          ),
        ),
      ),
    ),
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      brightness: Brightness.light,
      color: Colors.white,
      elevation: 1,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    dividerColor: Colors.grey.shade300,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      subtitle1: TextStyle(
        color: Colors.grey,
        fontSize: 8,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    snackBarTheme: SnackBarThemeData(
      elevation: 1,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade900),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all<Size>(Size.zero),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      headline6: TextStyle(
        color: Colors.white,
        // fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      subtitle1: TextStyle(
        color: Colors.grey,
        // fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
    ),
    highlightColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Colors.grey.shade900,
      elevation: 1,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    dividerColor: Colors.grey.shade700,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primarySwatch: Colors.blue,
  );
}
