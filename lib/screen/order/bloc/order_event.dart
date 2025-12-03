
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oms_ecommerce/screen/order/model/order_model.dart';

abstract class OrderEvent extends Equatable{

}
class OrderReqEvent extends OrderEvent{
 final String? payment_method;
 final String? billing_address;
 final String? shipping_address;
 final String? invoice_email;
 final String? product_code;
 final String? quantity;
 final BuildContext? context;
  OrderReqEvent({
     this.payment_method,
     this.billing_address,
     this.shipping_address,
     this.invoice_email,
     this.product_code,
     this.quantity,
     this.context,
  });
  @override
  List<Object?> get props => [payment_method,billing_address,shipping_address,invoice_email,product_code,quantity,context];
}

class OrderCartEvent extends OrderEvent{
  int count;
  double productPrice;
  String? qtyUpdate;


  OrderCartEvent({required this.count,required this.productPrice,this.qtyUpdate});
  @override
  List<Object?> get props => [count,productPrice,qtyUpdate];
}

class OrderShowEvent extends OrderEvent{
  String status;
  OrderShowEvent({required this.status});
  @override
  List<Object?> get props => [status];
}