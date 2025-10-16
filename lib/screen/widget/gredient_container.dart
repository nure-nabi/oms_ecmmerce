import 'package:flutter/material.dart';


import '../../core/constant/colors_constant.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final bool? reverseGradient;
  const GradientContainer(
      {super.key, required this.child, this.reverseGradient = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: reverseGradient == true
              ? [gPrimaryColor.withOpacity(0.2), gPrimaryColor.withOpacity(0.2),primaryColor.withOpacity(0.2)] // Three colors when reversed
              : [gPrimaryColor.withOpacity(0.2), gPrimaryColor.withOpacity(0.2),primaryColor.withOpacity(0.2)], // Three colors normal order
        ),
      ),
      child: child,
    );
  }
}
