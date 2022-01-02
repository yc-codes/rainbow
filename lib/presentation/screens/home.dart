import 'dart:math';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:rainbow/constants/app_strings.dart';
import 'package:rainbow/presentation/screens/color.dart';
import 'package:rainbow/presentation/widgets/bottom_bar.dart';
import 'package:rainbow/presentation/widgets/snackbar.dart';
import 'package:rainbow/utility/extensions/colors.dart';
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
  final double _bottomBarHeight = 60;
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final int minColorLength = 2;
  final int maxColorLength = 10;

  @override
  void initState() {
    _getInitColors();
    super.initState();
  }

  Future<void> _getInitColors() async {
    final colors = await AppHive.home.get();
    _colorsList.addAll(colors);
    _notify();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final wrapperHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        _bottomBarHeight;
    final _colorHeight = wrapperHeight / _colorsList.length;

    return Scaffold(
      bottomNavigationBar: BottomBar(
        onGenerateClick: _refreshColors,
        onPlusClick: addColorToList,
        colorsList: _colorsList,
      ),
      body: Container(
        constraints: const BoxConstraints(),
        child: ReorderableListView(
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
          children: List.generate(_colorsList.length, (index) {
            final _color = Color(int.parse('0xFF${_colorsList[index]}'));
            final _textColor = TinyColor(_color).textColor();
            return Dismissible(
              key: Key(_colorsList[index]),
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
                  ScaffoldMessenger.of(context).clearSnackBars();
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
              child: OpenContainer<bool>(
                transitionType: _transitionType,
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return ColorScreen(color: _color);
                },
                closedShape: const RoundedRectangleBorder(),
                closedElevation: 0,
                closedColor: _color,
                middleColor: _color,
                openColor: Theme.of(context).scaffoldBackgroundColor,
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Container(
                    height: index == 0 ? statusBarHeight + _colorHeight : _colorHeight,
                    color: _color,
                    padding: EdgeInsets.only(right: 12, top: index == 0 ? statusBarHeight : 0),
                    alignment: Alignment.centerLeft,
                    child: ListTile(
                      tileColor: _color,
                      hoverColor: _color.darken(5),
                      title: Row(
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
                  );
                },
              ),
            );
          }),
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
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    _colorsList.add(returnRandomHex());
    AppHive.home.put(_colorsList);
    _notify();
  }

  void _refreshColors() {
    for (var i = 0; i < _colorsList.length; i++) {
      if (_lockedColorsList.contains(_colorsList[i])) continue;
      _colorsList[i] = returnRandomHex();
    }
    AppHive.home.put(_colorsList);
    _notify();
  }

  String returnRandomHex() {
    var _hex = '';
    do {
      _hex = (Random().nextDouble() * 16777215).round().toRadixString(16);
    } while (_hex.length < 6);
    return _hex;
  }

  void _notify() {
    if (mounted) {
      setState(() {});
    }
  }
}
