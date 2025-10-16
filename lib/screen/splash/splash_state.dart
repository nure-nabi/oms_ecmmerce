import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/services/routeHelper/route_name.dart';

class SplashState extends ChangeNotifier {
  SplashState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(context);
  set getContext(value) {
    _context = value;

    ///
    startTimer();
  }

  startTimer() {
    Future.delayed(const Duration(seconds: 1), () async {
      await navigateUser();
    });
  }

  navigateUser() async {


    return navigator.pushReplacementNamed(loginHomePath);
  }
}
