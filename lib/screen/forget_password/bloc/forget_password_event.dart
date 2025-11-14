import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable{}

class ForgetPasswordReqEvent extends ForgetPasswordEvent{
  String email;
  ForgetPasswordReqEvent({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
}