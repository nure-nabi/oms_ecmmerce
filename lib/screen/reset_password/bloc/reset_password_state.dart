import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/forget_password/model/forget_password_model.dart';

import '../../../../basic_model/basic_model.dart';

abstract class ResetPasswordState extends Equatable{}

class ResetPasswordInitialState extends ResetPasswordState{
  @override
  List<Object?> get props =>[];
}
class ResetPasswordLoadingState extends ResetPasswordState{
  @override
  List<Object?> get props =>[];
}
class ResetPasswordLoadedState extends ResetPasswordState{
  BasicModel basicModel;
  ResetPasswordLoadedState({required this.basicModel});
  @override
  List<Object?> get props =>[basicModel];
}
class ResetPasswordErrorState extends ResetPasswordState{
  String? errorMsg;
  ResetPasswordErrorState({this.errorMsg});
  @override
  List<Object?> get props =>[];
}