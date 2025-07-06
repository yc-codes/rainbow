import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData lightTheme = AppThemes.darkTheme.copyWith(
    dividerColor: Colors.blue,
    scaffoldBackgroundColor: Colors.pink.shade100,
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
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade900),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all<Size>(Size.zero),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        titleMedium: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    ),
    highlightColor: Colors.transparent,
    // typography: Typography(),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Colors.grey.shade900,
      elevation: 1,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16,
        // fontWeight: FontWeight.w500,
      ),
    ),
    dividerColor: Colors.grey.shade700,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primarySwatch: Colors.blue,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
