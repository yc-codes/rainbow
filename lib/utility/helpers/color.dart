import 'dart:math';

String randomHexColor() {
  var _hex = '';
  do {
    _hex = (Random().nextDouble() * 16777215).round().toRadixString(16);
  } while (_hex.length < 6);
  return _hex;
}
