import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:rainbow/constants/app_constants.dart';
import 'package:rainbow/models/favorite.dart';

class AppHive {
  static HomePalette home = HomePalette();
  static FavoritePalette favorites = FavoritePalette();
}

class HomePalette {
  static HomeLockedColors lockedColors = HomeLockedColors();

  void put(List<String> colorsList) async {
    var box = await Hive.openBox('colors');
    await box.put('data', jsonEncode(colorsList));
  }

  Future<String> get() async {
    var box = await Hive.openBox('colors');
    String colors =
        box.get('data', defaultValue: AppConstants.initialhomePalette);
    return colors;
  }
}

class HomeLockedColors {
  static void put(List<String> colors) async {
    var box = await Hive.openBox('locked_colors');
    await box.put('data', jsonEncode(colors));
  }

  static Future<String?> get() async {
    var box = await Hive.openBox('locked_colors');
    String? colors = box.get('data');
    return colors;
  }
}

class FavoritePalette {
  Future<void> put(String name, List<String> colors) async {
    var box = await Hive.openBox<Favorite>('favorite_colors');
    await box.add(Favorite(name, colors));
    await box.close();
  }

  Future<List<Favorite>> get() async {
    var box = await Hive.openBox<Favorite>('favorite_colors');
    return box.values.toList().reversed.toList();
  }
}
