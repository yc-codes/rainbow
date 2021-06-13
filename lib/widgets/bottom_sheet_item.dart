import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  final void Function() onClick;
  final String text;
  final IconData icon;

  const BottomSheetItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      horizontalTitleGap: 0,
      onTap: () {
        onClick();
        Navigator.pop(context);
      },
    );
  }
}
