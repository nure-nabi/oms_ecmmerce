import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/theme/theme_event.dart';

import '../storage/hive_storage.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode>{
  ThemeBloc() : super(ThemeMode.light){
    on<ThemeReqEvent>((event,emit){
       HiveStorage.setPermission("Thememode", event.isDark);
      //HiveStorage.setPermission("Thememode", event.isDark ? ThemeMode.dark : ThemeMode.light);
     emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
    });
  }
}