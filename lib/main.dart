import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rainbow/constants/themes.dart';
import 'package:rainbow/data/models/favorite.dart';
import 'package:rainbow/presentation/screens/home.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteAdapter());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(const RainbowApp()),
  );
}

class RainbowApp extends StatelessWidget {
  const RainbowApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      // isToolbarVisible: false,
      builder: (context) => MaterialApp(
        title: 'Rainbow',
        // useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.darkTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.dark,
        home: const Home(),
      ),
    );
  }
}
