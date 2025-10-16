import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable{}

class ProfileReqEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];
}

class ProfileClearDataEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];

}