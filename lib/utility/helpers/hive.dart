import 'package:hive/hive.dart';
import 'package:rainbow/constants/app_constants.dart';
import 'package:rainbow/data/models/favorite.dart';

const colorsKey = 'colors';
const lockedColorsKey = 'locked_colors';
const favoriteColorsKey = 'favorite_colors';

class AppHive {
  static HomePalette home = HomePalette();
  static FavoritePalette favorites = FavoritePalette();
}

class HomePalette {
  static HomeLockedColors lockedColors = HomeLockedColors();

  Future<void> put(List<String> colorsList) async {
    final box = Hive.box<List<String>>(colorsKey);
    await box.put('data', colorsList);
  }

  Future<List<String>> get() async {
    final box = Hive.box<List<String>>(colorsKey);
    final colors = box.get('data', defaultValue: AppConstants.initialhomePalette);
    return colors ?? [];
  }
}

class HomeLockedColors {
  static Future<void> put(List<String> colors) async {
    final box = Hive.box<List<String>>(lockedColorsKey);
    await box.put('data', colors);
  }

  static Future<List<String>> get() async {
    final box = Hive.box<List<String>>(lockedColorsKey);
    final colors = box.get('data', defaultValue: []);
    return colors ?? [];
  }
}

class FavoritePalette {
  Future<void> put(String name, List<String> colors) async {
    final box = await Hive.openBox<Favorite>(favoriteColorsKey);
    await box.add(Favorite(name, colors));
    await box.close();
  }

  Future<List<Favorite>> get() async {
    final box = Hive.box<Favorite>(favoriteColorsKey);
    return box.values.toList().reversed.toList();
  }
}
