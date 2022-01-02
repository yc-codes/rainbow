import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  @override
  final Widget content;
  @override
  final SnackBarAction? action;

  const AppSnackBar({
    required this.content,
    this.action,
  }) : super(
          content: content,
          action: action,
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        );
}
