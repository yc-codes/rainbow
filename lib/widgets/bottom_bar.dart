import 'package:flutter/material.dart';
import 'package:rainbow/screens/favorites.dart';
import 'package:rainbow/utility/hive_helpers.dart';
import 'package:rainbow/utility/page_transition.dart';
import 'package:rainbow/widgets/bottom_sheet_item.dart';
import 'package:rainbow/widgets/dialog.dart' as App;
import 'package:rainbow/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final _formKey = GlobalKey<FormState>();

    TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => App.AppAlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        insetPadding: EdgeInsets.zero,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        title: Container(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Palette',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter palette name';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Palette Name',
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          Container(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await hiveSaveFavoritePalette(
                    _nameController.text.trim(),
                    colorsList,
                  );
                  var snackBar = AppSnackBar(
                    content: Text('Pelette added to Favorites'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                }
              },
              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
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
                icon: Icons.upcoming,
                onClick: () async {
                  String _url =
                      "https://github.com/yc-codes/rainbow/blob/master/README.md#upcoming-features";
                  await canLaunch(_url)
                      ? await launch(_url)
                      : throw 'Could not launch $_url';
                },
                text: "Upcoming Features",
              ),
              BottomSheetItem(
                icon: Icons.help_outline,
                onClick: () async {
                  String _url =
                      "https://github.com/yc-codes/rainbow/blob/master/README.md#how-to-use";
                  await canLaunch(_url)
                      ? await launch(_url)
                      : throw 'Could not launch $_url';
                },
                text: "How to use",
              ),
              // BottomSheetItem(
              //   icon: Icons.settings,
              //   onClick: () {
              //     ScaffoldMessenger.of(context)
              //         .showSnackBar(comingSoonSnackBar(context));
              //   },
              //   text: "Settings",
              // ),
            ],
          ),
        );
      },
    );
  }
}
