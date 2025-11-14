import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/forget_password/model/forget_password_model.dart';

import '../../../../basic_model/basic_model.dart';

abstract class ChangePasswordState extends Equatable{}

class ChangePasswordInitialState extends ChangePasswordState{
  @override
  List<Object?> get props =>[];
}
class ChangePasswordLoadingState extends ChangePasswordState{
  @override
  List<Object?> get props =>[];
}
class ChangePasswordLoadedState extends ChangePasswordState{
  BasicModel basicModel;
  ChangePasswordLoadedState({required this.basicModel});
  @override
  List<Object?> get props =>[basicModel];
}
class ChangePasswordErrorState extends ChangePasswordState{
  String? errorMsg;
  ChangePasswordErrorState({this.errorMsg});
  @override
  List<Object?> get props =>[];
}