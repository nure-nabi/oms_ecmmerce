import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable{

}

class SplashInitialState extends SplashState{
  @override
  List<Object?> get props => [];
}

class SplashLoadingState extends SplashState{
  @override
  List<Object?> get props => [];
}

class SplashLoadedState extends SplashState{
  String? value;
  SplashLoadedState({required this.value});
  @override
  List<Object?> get props => [];
}

class SplashErrorState extends SplashState{
  String? errorMsg;
  SplashErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}