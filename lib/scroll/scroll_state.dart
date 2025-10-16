import 'package:equatable/equatable.dart';

abstract class ScrollState extends Equatable{}

class ScrollInitialState extends ScrollState{
  @override
  List<Object?> get props => [];
}

class ScrollLoadingState extends ScrollState{
  @override
  List<Object?> get props => [];
}

class ScrollLoadedState extends ScrollState{
  bool scrollFlag;
  ScrollLoadedState({required this.scrollFlag});
  @override
  List<Object?> get props => [scrollFlag];
}

class ScrollErrorState extends ScrollState{
  @override
  List<Object?> get props => [];
}