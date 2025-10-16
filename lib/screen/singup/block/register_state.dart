import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';

abstract class RegisterState extends Equatable{

}
class RegisterInitialState extends RegisterState{
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState{
  @override
  List<Object?> get props => [];
}

class RegisterLoadedState extends RegisterState{
  RegisterResModel? registerResModel;
  RegisterLoadedState({ required this.registerResModel});
  @override
  List<Object?> get props => [registerResModel];
}

class RegisterErrorState extends RegisterState{
  String? errorMsg;
  RegisterErrorState({this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];

}