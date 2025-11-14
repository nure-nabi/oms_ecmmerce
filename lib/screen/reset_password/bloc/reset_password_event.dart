import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable{}

class ResetPasswordReqEvent extends ResetPasswordEvent{
  String email;
  String reset_code;
  String new_password;
  String confirm_new_password;
  ResetPasswordReqEvent({required this.email,required this.reset_code, required this.new_password,required this.confirm_new_password});
  @override
  // TODO: implement props
  List<Object?> get props => [email,reset_code,new_password,confirm_new_password];
}

