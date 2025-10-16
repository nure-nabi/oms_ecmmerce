import 'package:equatable/equatable.dart';

abstract class ContactusState extends Equatable{}

class ContactInitialState extends ContactusState{
  @override
  List<Object?> get props => [];
}

class ContactLoadingState extends ContactusState{
  @override
  List<Object?> get props => [];
}

class ContactLoadedState extends ContactusState{
  @override
  List<Object?> get props => [];
}

class ContactErrorState extends ContactusState{
  String errorMsg;
  ContactErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}