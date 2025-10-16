import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../model/cart_model.dart';

abstract class CartEvent extends Equatable{

}

class CartReqEvent extends CartEvent{
  int? count;
 final bool? checkedCart;
  CartReqEvent({this.count,this.checkedCart});
  @override
  List<Object?> get props => [count,checkedCart];
}

class CartIncrementEvent extends CartEvent{
  int? index;
  int count=0;
  int? id=0;
  int addOne;
  bool? updateFlag;
  String? product_code;

  CartIncrementEvent({required this.count,this.index,this.id,required this.addOne,this.updateFlag,this.product_code});
  @override
  List<Object?> get props => [count,index,id,addOne,updateFlag,product_code];
}

class CartDecrementEvent extends CartEvent{
  int? index;
  int count=0;
  int? id=0;
  int addOne;
  bool? updateFlag;
  String? product_code;
  CartDecrementEvent({required this.count,this.index,this.id,required this.addOne,this.updateFlag,this.product_code});
  @override
  List<Object?> get props => [count,index,id,addOne,updateFlag,product_code];
}

class CartItemRemoveByIdEvent extends CartEvent{
  int id=0;
  final bool? checkedCart;
  BuildContext context;
  CartItemRemoveByIdEvent({required this.id,this.checkedCart,required this.context});
  @override
  List<Object?> get props => [id,checkedCart,context];
}

class CartItemRemoveEvent extends CartEvent{
  CartItemRemoveEvent();
  @override
  List<Object?> get props => [];
}

class CartItemCheckeEvent extends CartEvent{
  int index;
  bool? checked;
  String? checkedValue;
  CartProductModel? cartProductModel;
  List<CartProductModel>? tempCartList;
  CartItemCheckeEvent({required this.index,this.checked,this.checkedValue,this.tempCartList,this.cartProductModel});
  @override
  List<Object?> get props => [index,checked,checkedValue,tempCartList,cartProductModel];
}

class CartItemsSelectAllEvent extends CartEvent{
  bool checkedCart;
  String? selectAll;
  CartItemsSelectAllEvent({required this.checkedCart,this.selectAll});
  @override
  List<Object?> get props => [checkedCart];
}

class CartItemsBuyEvent extends CartEvent{
  final String? payment_method;
  final String? billing_address;
  final String? shipping_address;
  final String? invoice_email;
  final String? subtotal;
  final String? shipping;
  final String? grandtotal;
  final List<String>? selected_items;
  final BuildContext? context;

  CartItemsBuyEvent({
    this.payment_method,
    this.billing_address,
    this.shipping_address,
    this.invoice_email,
    this.subtotal,
    this.shipping,
    this.grandtotal,
    this.selected_items,
    this.context,
  });
  @override
  List<Object?> get props => [payment_method,billing_address,
    shipping_address,invoice_email,
    subtotal,shipping,grandtotal,selected_items,context,];
}

class CartItemTempDataEvent extends CartEvent{
  List<CartProductModel>? tempCartList;
  CartItemTempDataEvent({required this.tempCartList});
  @override
  // TODO: implement props
  List<Object?> get props => [tempCartList];
}

class CartClearEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}
