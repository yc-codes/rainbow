import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorScreen extends StatefulWidget {
  final Color color;

  ColorScreen({
    required this.color,
  });
  @override
  _ColorScreenState createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  List<TinyColor> colorsList = [];

  @override
  void initState() {
    for (var i = 0; i < 12; i++) {
      colorsList.add(TinyColor(widget.color));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.color.hashCode.toString()),
      ),
      body: Container(
        constraints: BoxConstraints(),
        child: ListView.builder(
          itemCount: colorsList.length,
          itemBuilder: (BuildContext context, int index) {
            TinyColor color = colorsList[index];
            return Container(
              height: 60,
              width: double.infinity,
              color: color.color,
              child: Text(
                color.hashCode.toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}
