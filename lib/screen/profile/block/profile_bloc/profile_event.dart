import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable{}

class ProfileReqEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];
}

class ProfileClearDataEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];

}

class AccountRemovedEvent extends ProfileEvent{
   final BuildContext context;
  AccountRemovedEvent({required this.context});
  @override
  List<Object?> get props => [context];

}