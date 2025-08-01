import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rainbow/data/models/favorite.dart';

import 'package:rainbow/utility/helpers/hive.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  List<Favorite> paletteList = [];
  List<int> selectedItem = [];

  @override
  void initState() {
    super.initState();
    getPalettes();
  }

  Future<void> getPalettes() async {
    paletteList = await AppHive.favorites.get();
    _notify();
  }

  void _notify() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log(selectedItem.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Palettes',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     tooltip: 'Backup Palettes',
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     icon: const Icon(
        //       Icons.backup,
        //     ),
        //   )
        // ],
      ),
      body: Container(
        constraints: const BoxConstraints(),
        child: ListView.builder(
          itemCount: paletteList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              key: Key('favorite_$index'),
              title: Text(
                paletteList[index].name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 6, bottom: 8),
                child: Row(
                  children: [
                    ...paletteList[index].colors.asMap().entries.map((element) {
                      final first = element.key == 0;
                      final last = element.key == (paletteList[index].colors.length - 1);
                      final mySelectionId = [index, element.key];
                      final isSelect = selectedItem.equals(mySelectionId);
                      return Expanded(
                        key: Key('item_$index${element.key}'),
                        flex: isSelect ? 4 : 1,
                        child: GestureDetector(
                          onTap: () {
                            log(mySelectionId.toString());
                            selectedItem = mySelectionId;
                            _notify();
                            log(selectedItem.toString());
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutExpo,
                            decoration: BoxDecoration(
                              color: Color(int.parse('0xFF${element.value}')),
                              borderRadius: BorderRadius.only(
                                topLeft: first ? const Radius.circular(8) : Radius.zero,
                                bottomLeft: first ? const Radius.circular(8) : Radius.zero,
                                topRight: last ? const Radius.circular(8) : Radius.zero,
                                bottomRight: last ? const Radius.circular(8) : Radius.zero,
                              ),
                            ),
                            height: 38,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

extension on List<int> {
  bool equals(List<int> list) {
    return listEquals<int>(this, list) == true;
  }
}
