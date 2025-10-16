import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';

abstract class ComplainState extends Equatable{}

class ComplainInitialState extends ComplainState{
  @override
  List<Object?> get props => [];
}

class ComplainLoadingState extends ComplainState{
  @override
  List<Object?> get props => [];
}

class ComplainLoadedState extends ComplainState{
  BasicModel basicModel;
  ComplainLoadedState({required this.basicModel});
  @override
  List<Object?> get props => [];
}

class ComplainErrorState extends ComplainState{
  String errorMsg;
  ComplainErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}