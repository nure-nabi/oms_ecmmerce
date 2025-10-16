import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/verification_register/model/verification_model.dart';

abstract class VerificationState extends Equatable{

}

class VerificationInitialState extends VerificationState{
  @override
  List<Object?> get props => [];
}

class VerificationLoadingState extends VerificationState{
  @override
  List<Object?> get props => [];
}

class VerificationLoadedState extends VerificationState{
  VerificationResModel? verificationResModel;
  VerificationLoadedState({required this.verificationResModel});
  @override
  List<Object?> get props => [verificationResModel];
}

class VerificationErrorState extends VerificationState{
  String? errorMsg;
  VerificationErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}