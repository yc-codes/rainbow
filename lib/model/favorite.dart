import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 1)
class Favorite extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> colors;

  Favorite(
    this.name,
    this.colors,
  );

  @override
  String toString() => 'Favorite(name: $name, colors: $colors)';
}
