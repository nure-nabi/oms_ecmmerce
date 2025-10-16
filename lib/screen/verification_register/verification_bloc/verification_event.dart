import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/verification_register/model/verification_model.dart';

abstract class VerificationEvent extends Equatable{

}

class VerificationReqEvent extends VerificationEvent{
  VerificationReqModel? verificationReqModel;
  VerificationReqEvent({required this.verificationReqModel});
  @override
  List<Object?> get props => [verificationReqModel];
}