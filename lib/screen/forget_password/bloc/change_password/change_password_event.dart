import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable{}

class ChangePasswordReqEvent extends ChangePasswordEvent{
  String oldPassword;
  String newPassword;
  String newConfirmPassword;
  ChangePasswordReqEvent({required this.oldPassword,required this.newPassword, required this.newConfirmPassword});
  @override
  // TODO: implement props
  List<Object?> get props => [oldPassword,newPassword,newConfirmPassword];
}