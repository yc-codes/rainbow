import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({
    bool leadingHashSign = false,
    bool leadingAlpha = false,
  }) =>
      '${leadingHashSign ? '#' : ''}'
              '${leadingAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
              '${red.toRadixString(16).padLeft(2, '0')}'
              '${green.toRadixString(16).padLeft(2, '0')}'
              '${blue.toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();

  String toRGBString() => '${red.toString()}, '
          '${green.toString()}, '
          '${blue.toString()}'
      .toUpperCase();

  Color textColor() => TinyColor(this).isDark() ? Colors.white : Colors.black;
}

extension TinyHexColor on TinyColor {
  Color textColor() => this.isDark() ? Colors.white : Colors.black;
}
