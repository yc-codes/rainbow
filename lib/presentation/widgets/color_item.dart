// import 'dart:ui';

// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:rainbow/screens/color.dart';

// class ColorListItem extends StatelessWidget {
//   const ColorListItem({
//     Key? key,
//     required this.color,
//   }) : super(key: key);

//   final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return OpenContainer<bool>(
//       transitionType: _transitionType,
//       openBuilder: (BuildContext _, VoidCallback openContainer) {
//         return ColorScreen(color: color);
//       },
//       // onClosed: _showMarkedAsDoneSnackbar,
//       tappable: true,
//       closedShape: const RoundedRectangleBorder(),
//       closedElevation: 0.0,
//       closedColor: color,
//       middleColor: color,
//       openColor: Theme.of(context).scaffoldBackgroundColor,
//       closedBuilder: (BuildContext _, VoidCallback openContainer) {
//         return Container(
//           alignment: Alignment.center,
//           height: _colorHeight,
//           color: color,
//           padding: EdgeInsets.only(right: 12),
//           child: ListTile(
//             tileColor: color,
//             hoverColor: color.darken(5),
//             title: Container(
//               height: _colorHeight,
//               alignment: Alignment.centerLeft,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     _colorsList[index].toUpperCase(),
//                     style: TextStyle(
//                       color: _textColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       fontFeatures: [
//                         FontFeature.tabularFigures(),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _lockedColorsList.contains(_colorsList[index])
//                           ? Icons.lock
//                           : Icons.lock_open,
//                     ),
//                     color: color.isDark ? color.lighten(20) : color.darken(20),
//                     onPressed: () {
//                       if (_lockedColorsList.contains(_colorsList[index])) {
//                         _lockedColorsList.remove(_colorsList[index]);
//                       } else {
//                         _lockedColorsList.add(_colorsList[index]);
//                       }
//                       if (mounted) _notify();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
