import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ConnectIpsEvent extends Equatable{

}

class ConnectIpsReq extends ConnectIpsEvent{
  final String? payment_method;
  final String? billing_address;
  final String? shipping_address;
  final String? invoice_email;
  final String? product_code;
  final String? quantity;
  final BuildContext? context;
  ConnectIpsReq({
    this.payment_method,
    this.billing_address,
    this.shipping_address,
    this.invoice_email,
    this.product_code,
    this.quantity,
    this.context,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}