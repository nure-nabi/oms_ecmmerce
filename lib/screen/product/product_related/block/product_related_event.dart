import 'package:equatable/equatable.dart';

abstract class ProductRelatedEvent extends Equatable{}

class ProductRelatedReqEvent extends ProductRelatedEvent{
  String? productCode;
  ProductRelatedReqEvent({required this.productCode});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductRelatedWishListFlagReqEvent extends ProductRelatedEvent{
  bool flag;
  int index;
  ProductRelatedWishListFlagReqEvent({required this.flag, required this.index});
  @override
  List<Object?> get props => [];
}