import 'package:flutter/material.dart';
import 'package:rainbow/constants/app_constants.dart';
import 'package:rainbow/constants/app_urls.dart';
import 'package:rainbow/presentation/screens/favorites.dart';
import 'package:rainbow/presentation/widgets/bottom_sheet_item.dart';
import 'package:rainbow/presentation/widgets/snackbar.dart';
import 'package:rainbow/utility/helpers/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.onGenerateClick,
    required this.onPlusClick,
    required this.colorsList,
  }) : super(key: key);

  final void Function() onGenerateClick;
  final void Function() onPlusClick;
  final List<String> colorsList;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8 + bottomPadding),
      height: AppConstants.bottomBarHeight + bottomPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: () {
              bottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 8),
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

  SnackBar comingSoonSnackBar(BuildContext context) {
    return const AppSnackBar(
      content: Text('Coming Soon'),
    );
  }

  void saveToFavorite(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _nameController = TextEditingController();

    showDialog<AlertDialog>(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
            decoration: const InputDecoration(
              labelText: 'Palette Name',
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  AppHive.favorites
                      .put(
                    _nameController.text.trim(),
                    colorsList,
                  )
                      .then((value) {
                    const snackBar = AppSnackBar(
                      content: Text('Pelette added to Favorites'),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  });
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

  void bottomSheet(BuildContext context) {
    showModalBottomSheet<Container>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
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
                onClick: () => saveToFavorite(context),
                text: 'Save to Favorites',
              ),
              BottomSheetItem(
                icon: Icons.favorite_rounded,
                onClick: () {
                  Navigator.push<Route>(context, MaterialPageRoute(builder: (context) => const FavoritesScreen()));
                },
                text: 'Favorites',
              ),
              BottomSheetItem(
                icon: Icons.help_outline,
                onClick: () async {
                  const _url = AppURLs.howToUse;
                  if (await canLaunch(_url)) await launch(_url);
                },
                text: 'How to use?',
              ),
            ],
          ),
        );
      },
    );
  }
}
