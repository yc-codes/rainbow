import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:rainbow/bloc/theme.dart';
import 'package:rainbow/constants/app_constants.dart';
import 'package:rainbow/constants/app_strings.dart';
import 'package:rainbow/data/models/favorite.dart';
import 'package:rainbow/presentation/screens/color.dart';
import 'package:rainbow/presentation/widgets/bottom_bar.dart';
import 'package:rainbow/presentation/widgets/snackbar.dart';
import 'package:rainbow/utility/extensions/colors.dart';
import 'package:rainbow/utility/helpers/color.dart';
import 'package:rainbow/utility/helpers/hive.dart';
import 'package:tinycolor/tinycolor.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final List<String> _colorsList = [];
  final List<String> _lockedColorsList = [];
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final int minColorLength = AppConstants.minColorLength;
  final int maxColorLength = AppConstants.maxColorLength;

  @override
  void initState() {
    super.initState();
    _openHiveBoxes();
  }

  @override
  void dispose() {
    _closeHiveBoxes();
    super.dispose();
  }

  Future<void> _closeHiveBoxes() async {
    await Hive.close();
  }

  Future<void> _openHiveBoxes() async {
    await Hive.openBox<List<String>>(colorsKey);
    await Hive.openBox<List<String>>(lockedColorsKey);
    await Hive.openBox<Favorite>(favoriteColorsKey);
    await _getInitColors();
  }

  Future<void> _getInitColors() async {
    final colors = await AppHive.home.get();
    _colorsList.addAll(colors);
    _notify();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final statusBarHeight = media.padding.top;
    final wrapperHeight = media.size.height - media.padding.top - media.padding.bottom - AppConstants.bottomBarHeight;
    final _colorHeight = wrapperHeight / _colorsList.length;

    log('build');

    return Scaffold(
      bottomNavigationBar: BottomBar(
        onGenerateClick: _refreshColors,
        onPlusClick: addColorToList,
        colorsList: _colorsList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ThemeCubit>().toggleTheme();
        },
        child: const Icon(Icons.palette_sharp),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints(),
        child: ReorderableListView.builder(
          itemCount: _colorsList.length,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final _color = _colorsList.removeAt(oldIndex);
            _colorsList.insert(newIndex, _color);
            _notify();
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final _color = Color(int.parse('0xFF${_colorsList[index]}'));
            final _textColor = _color.textColor();
            return OpenContainer<bool>(
              key: Key('color_container_$index'),
              transitionType: _transitionType,
              openBuilder: (BuildContext _, VoidCallback openContainer) => ColorScreen(color: _color),
              closedShape: const RoundedRectangleBorder(),
              closedElevation: 0,
              middleColor: _color,
              closedColor: _color,
              openColor: _color,
              closedBuilder: (BuildContext _, VoidCallback openContainer) => AnimatedContainer(
                key: Key('color_$index'),
                color: _color,
                height: index == 0 ? statusBarHeight + _colorHeight : _colorHeight,
                padding: EdgeInsets.only(top: index == 0 ? statusBarHeight : 0),
                // alignment: Alignment.centerLeft,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutExpo,
                child: Dismissible(
                  key: Key('dismissable_$_color'),
                  confirmDismiss: (DismissDirection direction) {
                    if (direction == DismissDirection.startToEnd) {
                      if (_lockedColorsList.contains(_colorsList[index])) {
                        _lockedColorsList.remove(_colorsList[index]);
                      } else {
                        _lockedColorsList.add(_colorsList[index]);
                      }
                      _notify();
                      return Future<bool>.value(false);
                    }

                    if (_colorsList.length == minColorLength) {
                      final snackBar = AppSnackBar(
                        content: const Text("You can't remove any more colors"),
                        action: SnackBarAction(
                          label: 'OKAY',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return Future<bool>.value(false);
                    }

                    return Future<bool>.value(true);
                  },
                  onDismissed: (DismissDirection direction) {
                    _lockedColorsList.remove(_colorsList[index]);
                    _colorsList.removeAt(index);
                    AppHive.home.put(_colorsList);
                    _notify();
                  },
                  background: AnimatedContainer(
                    color: _color.darken(6),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    curve: Curves.easeOutExpo,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    child: Icon(
                      _lockedColorsList.contains(_colorsList[index]) ? Icons.lock_open : Icons.lock,
                      color: _color.textColor(),
                      size: 32,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: _color.darken(6),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Icon(
                      Icons.remove_circle_outline,
                      color: _color.textColor(),
                      size: 32,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _colorsList[index].toUpperCase(),
                          style: TextStyle(
                            color: _textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFeatures: const [
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _lockedColorsList.contains(_colorsList[index]) ? Icons.lock : Icons.lock_open,
                          ),
                          color: _color.isDark ? _color.lighten(20) : _color.darken(20),
                          onPressed: () {
                            if (_lockedColorsList.contains(_colorsList[index])) {
                              _lockedColorsList.remove(_colorsList[index]);
                            } else {
                              _lockedColorsList.add(_colorsList[index]);
                            }
                            if (mounted) _notify();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void addColorToList() {
    if (_colorsList.length == maxColorLength) {
      final snackBar = AppSnackBar(
        content: const Text(AppStrings.noMoreColors),
        action: SnackBarAction(
          label: AppStrings.okay,
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    _colorsList.add(randomHexColor());
    AppHive.home.put(_colorsList);
    _notify();
  }

  void _refreshColors() {
    for (var i = 0; i < _colorsList.length; i++) {
      if (_lockedColorsList.contains(_colorsList[i])) continue;
      _colorsList[i] = randomHexColor();
    }
    AppHive.home.put(_colorsList);
    _notify();
  }

  void _notify() {
    if (mounted) {
      setState(() {});
    }
  }
}
