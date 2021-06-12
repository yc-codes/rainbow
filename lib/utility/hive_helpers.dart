import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rainbow/model/favorite.dart';

void hiveSaveColors(List<String> colors) async {
  var box = await Hive.openBox('colors');
  box.put('data', jsonEncode(colors));
}

Future<String?> hiveGiveColors() async {
  var box = await Hive.openBox('colors');
  String? colors = box.get('data');
  return colors;
}

void hiveSaveLockedColors(List<String> colors) async {
  var box = await Hive.openBox('locked_colors');
  box.put('data', jsonEncode(colors));
}

Future<String?> hiveGiveLockedColors() async {
  var box = await Hive.openBox('locked_colors');
  String? colors = box.get('data');
  return colors;
}

Future<void> hiveSaveFavoritePalette(String name, List<String> colors) async {
  Box<Favorite> box = await Hive.openBox<Favorite>('favorite_colors');
  box.add(Favorite(name, colors));
  box.close();
}

Future<List<Favorite>> hiveGiveFavoritePalettes() async {
  Box<Favorite> box = await Hive.openBox<Favorite>('favorite_colors');
  return box.values.toList().reversed.toList();
}

// Future<String> hiveGiveTheme() async {
//   var box = await Hive.openBox('theme');
//   String theme = box.get('data', defaultValue: 'system');
//   return theme;
// }

// void hiveSaveTheme(ThemeMode theme) async {
//   var box = await Hive.openBox('theme');
//   box.put('data', theme);
// }
