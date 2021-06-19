import 'package:flutter/material.dart';
import 'package:rainbow/data/models/favorite.dart';

import 'package:rainbow/utility/helpers/hive.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Favorite> paletteList = [];

  @override
  void initState() {
    getPalettes();
    super.initState();
  }

  getPalettes() async {
    paletteList = await AppHive.favorites.get();
    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Palettes',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: "Backup Palettes",
            padding: const EdgeInsets.symmetric(horizontal: 16),
            icon: Icon(
              Icons.backup,
            ),
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints(),
        child: ListView.builder(
          itemCount: paletteList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                paletteList[index].name,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 6, bottom: 8),
                child: Row(
                  children: [
                    ...paletteList[index].colors.asMap().entries.map((element) {
                      bool first = element.key == 0;
                      bool last =
                          element.key == (paletteList[index].colors.length - 1);
                      return Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(int.parse('0xFF' + element.value)),
                            borderRadius: BorderRadius.only(
                              topLeft: first
                                  ? const Radius.circular(8)
                                  : Radius.zero,
                              bottomLeft: first
                                  ? const Radius.circular(8)
                                  : Radius.zero,
                              topRight:
                                  last ? const Radius.circular(8) : Radius.zero,
                              bottomRight:
                                  last ? const Radius.circular(8) : Radius.zero,
                            ),
                          ),
                          height: 40,
                        ),
                        fit: FlexFit.tight,
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
