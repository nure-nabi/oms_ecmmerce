import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WishlistEvent extends Equatable{}

class WishlistReqEvent extends WishlistEvent{

  @override
  List<Object?> get props => [];
}

class WishlistSaveEvent extends WishlistEvent{
  String productCode;
  BuildContext context;
  WishlistSaveEvent({required this.productCode,required this.context});
  @override
  List<Object?> get props => [productCode];
}

class WishlistRemovedEvent extends WishlistEvent{
  String item_code;
  String? product_code;
  BuildContext context;
  WishlistRemovedEvent({required this.item_code,this.product_code,required this.context});
  @override
  List<Object?> get props => [item_code,product_code,context];
}