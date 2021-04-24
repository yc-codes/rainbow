import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rainbow/utility/material_ink_splash.dart';
import 'package:tinycolor/tinycolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(0),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all<Size>(Size.zero),
          ),
        ),
        primarySwatch: Colors.blue,
        splashFactory: MaterialInkSplash.splashFactory,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _colorsList = [];
  List<String> _lockedColorsList = [];
  double _bottomBarHeight = 60;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 6; i++) {
      _colorsList.add(returnRandomHex());
    }
  }

  @override
  Widget build(BuildContext context) {
    double _colorHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            _bottomBarHeight) /
        _colorsList.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(),
          color: Colors.blueGrey.shade100,
          child: Column(
            children: [
              Expanded(
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    // final item =
                  },
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(_colorsList.length, (index) {
                    Color _color =
                        Color(int.parse('0xFF' + _colorsList[index]));
                    final _textColor = TinyColor(_color).isDark()
                        ? Colors.white
                        : Colors.black;
                    return Dismissible(
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
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.green,
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
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      child: Container(
                        height: _colorHeight,
                        color: _color,
                        child: ListTile(
                          title: Text(
                            '#' + _colorsList[index],
                            style: TextStyle(
                              color: _textColor,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        // print(_lockedColorsList);
                        // _lockedColorsList = [];
                        // _notify();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.info_outline,
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
    return (Random().nextDouble() * 16777215).round().toRadixString(16);
  }

  void _notify() {
    if (mounted) {
      setState(() {});
    }
  }
}
