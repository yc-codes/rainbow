import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:rainbow/constants/app_constants.dart';
import 'package:rainbow/data/models/favorite.dart';

class AppHive {
  static HomePalette home = HomePalette();
  static FavoritePalette favorites = FavoritePalette();
}

class HomePalette {
  static HomeLockedColors lockedColors = HomeLockedColors();

  void put(List<String> colorsList) async {
    var box = await Hive.openBox('colors');
    box.put('data', colorsList);
  }

  Future<List<String>> get() async {
    var box = await Hive.openBox('colors');
    List<String> colors = box.get('data', defaultValue: AppConstants.initialhomePalette);
    return colors;
  }
}

class HomeLockedColors {
  static void put(List<String> colors) async {
    var box = await Hive.openBox('locked_colors');
    box.put('data', jsonEncode(colors));
  }

  static Future<String?> get() async {
    var box = await Hive.openBox('locked_colors');
    String? colors = box.get('data');
    return colors;
  }
}

class FavoritePalette {
  Future<void> put(String name, List<String> colors) async {
    Box<Favorite> box = await Hive.openBox<Favorite>('favorite_colors');
    box.add(Favorite(name, colors));
    box.close();
  }

  Future<List<Favorite>> get() async {
    Box<Favorite> box = await Hive.openBox<Favorite>('favorite_colors');
    return box.values.toList().reversed.toList();
  }
}
