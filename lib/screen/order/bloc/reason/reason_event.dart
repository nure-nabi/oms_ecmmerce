import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ReasonEvent extends Equatable{}

class ReasonReqEven extends ReasonEvent{
  bool? policyChecked;
  String? reasonId;
  ReasonReqEven({this.policyChecked,this.reasonId="0"});
  @override
  List<Object?> get props => [policyChecked,reasonId];
}

class ReasonSaveEven extends ReasonEvent{
  String? orderId;
  String? reasonId;
  String? description;
  bool? check;
  BuildContext? context;

  ReasonSaveEven({this.orderId,this.reasonId,this.description,this.check,this.context});
  @override
  List<Object?> get props => [orderId,reasonId,description,check,context];
}