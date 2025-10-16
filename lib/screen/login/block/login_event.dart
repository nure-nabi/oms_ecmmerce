import 'package:equatable/equatable.dart';

import '../model/login_req_model.dart';

abstract class LoginEvent extends Equatable{

}

class LoginReqEvent extends LoginEvent{
  LoginReqModel? loginReqModel;
  LoginReqEvent({ required this.loginReqModel});
  @override
  List<Object?> get props => [loginReqModel];
}

class LoginResetReqEvent extends LoginEvent{
  @override
  List<Object?> get props => [];
}