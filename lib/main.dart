import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rainbow/screens/home.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter',
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(0),
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
        appBarTheme: AppBarTheme(
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
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter',
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(0),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey.shade900),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all<Size>(Size.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.5),
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: Colors.grey.shade900,
          elevation: 1,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        dividerColor: Colors.grey.shade700,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}
