import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_event.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent,SplashState>{
  SplashBloc() :super(SplashInitialState()){
    on<SplashReqEvent>((event, emit) async {
      emit(SplashLoadingState());
      // Wait for 5 seconds
      await Future.delayed(const Duration(seconds: 3));
      // After delay, emit loaded state
      emit(SplashLoadedState(value: 'Loading....'));

    });
  }
}