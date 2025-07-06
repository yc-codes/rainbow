import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  final void Function() onClick;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      horizontalTitleGap: 0,
      onTap: () {
        Navigator.pop(context);
        onClick();
      },
    );
  }
}
