import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/forget_password/model/forget_password_model.dart';

abstract class ForgetPasswordState extends Equatable{}

class ForgetPasswordInitialState extends ForgetPasswordState{
  @override
  List<Object?> get props =>[];
}
class ForgetPasswordLoadingState extends ForgetPasswordState{
  @override
  List<Object?> get props =>[];
}
class ForgetPasswordLoadedState extends ForgetPasswordState{
  ForgetPasswordResp forgetPasswordResp;
  ForgetPasswordLoadedState({required this.forgetPasswordResp});
  @override
  List<Object?> get props =>[];
}
class ForgetPasswordErrorState extends ForgetPasswordState{
  String? errorMsg;
  ForgetPasswordErrorState({this.errorMsg});
  @override
  List<Object?> get props =>[];
}