// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  const AppSnackBar({
    Key? key,
    required this.content,
    this.action,
  }) : super(
          key: key,
          content: content,
          action: action,
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        );

  @override
  final Widget content;

  @override
  final SnackBarAction? action;
}
