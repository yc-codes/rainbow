import 'dart:convert';
import 'package:hive/hive.dart';

void hiveSaveColors(List<String> colors) async {
  var box = await Hive.openBox('colors');
  box.put('data', jsonEncode(colors));
}

Future<String?> hiveGiveColors() async {
  var box = await Hive.openBox('colors');
  String? colors = box.get('data');
  return colors;
}
