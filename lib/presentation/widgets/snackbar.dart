import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  final Widget content;
  final SnackBarAction? action;

  AppSnackBar({
    required this.content,
    this.action,
  }) : super(
          content: content,
          action: action,
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        );
}
