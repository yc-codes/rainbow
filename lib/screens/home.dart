import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:rainbow/screens/color.dart';
import 'package:rainbow/screens/settings.dart';
import 'package:rainbow/utility/page_transition.dart';
import 'package:tinycolor/tinycolor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _colorsList = [];
  List<String> _lockedColorsList = [];
  double _bottomBarHeight = 60;

  @override
  void initState() {
    for (var i = 0; i < 6; i++) {
      _colorsList.add(returnRandomHex());
    }
    _getInitColors();
    super.initState();
  }

  _getInitColors() async {
    await Hive.openBox<String>('colors');
  }

  @override
  Widget build(BuildContext context) {
    double _colorHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            _bottomBarHeight) /
        _colorsList.length;

    return Scaffold(
      body: Container(
        constraints: BoxConstraints(),
        child: Column(
          children: [
            Expanded(
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
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(_colorsList.length, (index) {
                  final Color _color =
                      Color(int.parse('0xFF' + _colorsList[index]));
                  final Color _textColor =
                      TinyColor(_color).isDark() ? Colors.white : Colors.black;
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

                      return Future<bool>.value(true);
                    },
                    onDismissed: (DismissDirection direction) {
                      _lockedColorsList.remove(_colorsList[index]);
                      _colorsList.removeAt(index);
                      _notify();
                    },
                    background: Container(
                      color: _color.darken(),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Icon(
                        _lockedColorsList.contains(_colorsList[index])
                            ? Icons.lock_open
                            : Icons.lock_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    secondaryBackground: Container(
                      color: _color.darken(),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: _colorHeight,
                      color: _color,
                      padding: EdgeInsets.only(right: 12),
                      child: ListTile(
                        tileColor: _color,
                        hoverColor: _color.darken(5),
                        trailing: IconButton(
                          icon: Icon(
                            _lockedColorsList.contains(_colorsList[index])
                                ? Icons.lock
                                : Icons.lock_open,
                          ),
                          color: _color.isDark
                              ? _color.lighten(20)
                              : _color.darken(20),
                          onPressed: () {
                            if (_lockedColorsList
                                .contains(_colorsList[index])) {
                              _lockedColorsList.remove(_colorsList[index]);
                            } else {
                              _lockedColorsList.add(_colorsList[index]);
                            }
                            if (mounted) _notify();
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            goToScreen(ColorScreen(color: _color)),
                          );
                        },
                        title: Container(
                          height: _colorHeight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _colorsList[index].toUpperCase(),
                            style: TextStyle(
                              color: _textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: _bottomBarHeight,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(goToScreen(Settings()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.black54,
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: OutlinedButton(
                        onPressed: _refreshColors,
                        child: Text(
                          'Generate',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _colorsList.add(returnRandomHex());
                      _notify();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.add,
                        color: Colors.black54,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _refreshColors() {
    for (var i = 0; i < _colorsList.length; i++) {
      if (_lockedColorsList.contains(_colorsList[i])) continue;
      _colorsList[i] = returnRandomHex();
    }
    _notify();
  }

  String returnRandomHex() {
    String _hex = '';
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
