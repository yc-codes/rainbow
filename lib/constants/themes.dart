import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData darkTheme(BuildContext context) => ThemeData(
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
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
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
        textTheme: GoogleFonts.interTextTheme(
          const TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            subtitle1: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        highlightColor: Colors.transparent,
        // typography: Typography(),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          color: Colors.grey.shade900,
          elevation: 1,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: Theme.of(context).textTheme.bodyText2,
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
