import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.onGenerateClick,
    required this.onPlusClick,
    required this.onInfoClick,
  }) : super(key: key);
  final double _bottomBarHeight = 60;
  final void Function() onGenerateClick;
  final void Function() onPlusClick;
  final void Function() onInfoClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: _bottomBarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: onInfoClick,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.settings_outlined,
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
}
