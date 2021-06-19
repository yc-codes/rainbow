import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Text(
        'Generate',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
