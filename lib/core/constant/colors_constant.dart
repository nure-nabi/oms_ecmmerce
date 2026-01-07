import 'package:flutter/material.dart';

Map<int, Color> swatch = {
  50: const Color.fromRGBO(0, 0, 0, 0),
  100: const Color.fromRGBO(0, 0, 0, .1),
  200: const Color.fromRGBO(0, 0, 0, .2),
  300: const Color.fromRGBO(0, 0, 0, .3),
  400: const Color.fromRGBO(0, 0, 0, .4),
  500: const Color.fromRGBO(0, 0, 0, .5),
  600: const Color.fromRGBO(0, 0, 0, .6),
  700: const Color.fromRGBO(0, 0, 0, .7),
  800: const Color.fromRGBO(0, 0, 0, .8),
  900: const Color.fromRGBO(0, 0, 0, .9),
};

MaterialColor primarySwatch = MaterialColor(0xFF3F51B5, swatch);
Color primaryColor = const Color(0xff003466);
Color gPrimaryColor =   Color(0xff003466).withOpacity(0.5);
Color egPrimaryColor =  const Color(0XFFB7ABFF);
Color hintColor = Colors.black45;
// linear gradient
// at 0% B7ABFF
// at 56% DBB4FF
// at 100% FBC8A7
// MaterialColor primarySwatch = MaterialColor(0xFFEC407A, swatch);
// Color primaryColor = Colors.pink.shade400;
// Color gPrimaryColor = Colors.pink.shade100;
//  background: linear-gradient(to right, #ADE8FF 0%, #FEC1C2 100%);

/// Text Form Field Color
Color textFormFieldColor = primaryColor.withOpacity(0.1);

/// Border Color
Color borderColor = Colors.grey.shade300;
Color backgroundColor = Colors.grey.shade200;

///
Color errorColor = Colors.red.shade700;
Color successColor = Colors.green.shade700;


Color btnColor = Color(0xff1C1C91);
