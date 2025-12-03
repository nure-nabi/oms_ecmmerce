import 'package:flutter/cupertino.dart';

class ScreenHieght{
  static int  getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) return 2; // phones
    if (width < 900) return 3; // small tablets
    return 4; // large tablets or desktop
  }

  static double  getHieght(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) return 0.25; // phones
    if (width < 900) return 0.40; // small tablets
    return 0.40; // large tablets or desktop
  }
}