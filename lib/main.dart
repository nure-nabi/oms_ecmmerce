import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'config/app.dart';
import 'constant/values.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //   systemNavigationBarColor: Colors.black,
  //   statusBarIconBrightness: Brightness.light,
  // ));

  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init('${directory.path}/ecommerce');
  await Hive.openBox(HiveDatabase.user_prefs.name);

  runApp(const MyApp());
}

