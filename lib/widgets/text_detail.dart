import 'package:flutter/material.dart';
import 'package:rainbow/utility/helpers.dart';

class TextDetailView extends StatelessWidget {
  final String title;
  final String text;
  final Color? color;

  TextDetailView({
    required this.title,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: color,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color!.textColor().withOpacity(0.6),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: color!.textColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
