import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rainbow/widgets/text_detail.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:rainbow/utility/helpers.dart';

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
    for (var i = -20; i < 30; i += 10) {
      if (i < 0) {
        colorsList.add(TinyColor(widget.color).lighten(i.abs()));
      } else {
        colorsList.add(TinyColor(widget.color).darken(i));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: widget.color,
        title: Text(
          'View Color',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // iconTheme: IconThemeData(
        //   color: widget.color.textColor(),
        // ),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints(),
        child: ListView(
          children: [
            TextDetailView(
              title: 'HEX',
              text: widget.color.toHex(),
              color: widget.color,
            ),
            TextDetailView(
              title: 'RGB',
              text: widget.color.toRGBString(),
              color: widget.color,
            ),
            ListView.builder(
              itemCount: colorsList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (BuildContext context, int index) {
                TinyColor color = colorsList[index];
                return Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: color.color,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        color.color.toHex(),
                        style: TextStyle(
                          color: color.textColor(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        iconSize: 20,
                        color: color.textColor().withOpacity(0.6),
                        onPressed: () => Clipboard.setData(
                          ClipboardData(
                            text: color.color.toHex(leadingHashSign: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
