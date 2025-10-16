import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AddCartEvent extends Equatable{}

class AddCartReqEvent extends AddCartEvent{
  String? productCode;
  String? price;
  String? quantity;
  BuildContext context;
  AddCartReqEvent({required this.productCode,required this.price,required this.quantity,required this.context});
  @override
  List<Object?> get props => [productCode,price,quantity];
}