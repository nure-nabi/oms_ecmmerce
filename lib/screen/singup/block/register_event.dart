import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';

abstract class RegisterEvent extends Equatable{}


class RegisterReqEvent extends RegisterEvent{
   RegisterReqModel? registerReqModel;
   RegisterReqEvent({required this.registerReqModel});
  @override
  List<Object?> get props => [registerReqModel];

}