import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rainbow/utility/extensions/colors.dart';

class TextDetailView extends StatelessWidget {
  final String title;
  final String text;
  final Color color;

  const TextDetailView({
    required this.title,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: color,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color.textColor().withOpacity(0.6),
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: color.textColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            borderOnForeground: false,
            child: IconButton(
              icon: const Icon(Icons.copy),
              iconSize: 20,
              color: color.textColor().withOpacity(0.6),
              tooltip: 'Copy',
              onPressed: () => Clipboard.setData(
                ClipboardData(
                  text: text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
