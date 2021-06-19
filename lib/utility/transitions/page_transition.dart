import 'package:flutter/widgets.dart';

Route goToScreen(Widget _widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => _widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;

      var curve = Curves.easeOutExpo;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
