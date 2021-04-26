import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rainbow/screens/home.dart';
import 'package:rainbow/utility/material_ink_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow',
      theme: ThemeData(
        brightness: Brightness.light,
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
        colorScheme: ColorScheme.light(),
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
        splashFactory: MaterialInkSplash.splashFactory,
      ),
      // darkTheme: ThemeData(
      //   outlinedButtonTheme: OutlinedButtonThemeData(
      //     style: ButtonStyle(
      //       padding: MaterialStateProperty.all<EdgeInsets>(
      //         EdgeInsets.all(0),
      //       ),
      //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //       minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //         RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(12.5),
      //           side: BorderSide(color: Colors.red),
      //         ),
      //       ),
      //     ),
      //   ),
      //   appBarTheme: AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle.light,
      //     backgroundColor: Colors.grey.shade900,
      //     brightness: Brightness.dark,
      //   ),
      //   scaffoldBackgroundColor: Colors.black,
      //   primarySwatch: Colors.blue,
      //   splashFactory: MaterialInkSplash.splashFactory,
      // ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Home(),
    );
  }
}
