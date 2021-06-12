import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rainbow/model/favorite.dart';
import 'package:rainbow/screens/favorites.dart';
import 'package:rainbow/screens/settings.dart';
import 'package:rainbow/utility/hive_helpers.dart';
import 'package:rainbow/utility/page_transition.dart';
import 'package:rainbow/widgets/bottom_sheet_item.dart';
import 'package:rainbow/widgets/snackbar.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.onGenerateClick,
    required this.onPlusClick,
    required this.colorsList,
  }) : super(key: key);

  final double _bottomBarHeight = 60;
  final void Function() onGenerateClick;
  final void Function() onPlusClick;
  final List<String> colorsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: _bottomBarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: () {
              bottomSheet(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.more_horiz_rounded,
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 30,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: OutlinedButton(
                onPressed: onGenerateClick,
                child: Text(
                  'Generate',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: onPlusClick,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.add,
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SnackBar comingSoonSnackBar(context) {
    return AppSnackBar(
      content: Text('Coming Soon'),
    );
  }

  saveToFavorite(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        title: Text('Save Palette'),
        content: const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Palette Name',
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              await hiveSaveFavoritePalette("A2z", colorsList);
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
        ),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BottomSheetItem(
                icon: Icons.favorite_border_rounded,
                onClick: () {
                  saveToFavorite(context);
                },
                text: "Save to Favorites",
              ),
              BottomSheetItem(
                icon: Icons.share,
                onClick: () async {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(comingSoonSnackBar(context));
                },
                text: "Share Palette",
              ),
              BottomSheetItem(
                icon: Icons.favorite_rounded,
                onClick: () async {
                  Navigator.push(context, goToScreen(FavoritesScreen()));
                },
                text: "Favorites",
              ),
              BottomSheetItem(
                icon: Icons.image,
                onClick: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(comingSoonSnackBar(context));
                },
                text: "Generate Palette from Image",
              ),
              BottomSheetItem(
                icon: Icons.settings,
                onClick: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(comingSoonSnackBar(context));
                },
                text: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
