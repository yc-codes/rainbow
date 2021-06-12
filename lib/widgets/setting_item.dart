import 'package:flutter/material.dart';

class SettingListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const SettingListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 16.0,
      ),
      minVerticalPadding: 0.0,
      onTap: () {
        print("print");
      },
      leading: Container(
        height: 34,
        width: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
