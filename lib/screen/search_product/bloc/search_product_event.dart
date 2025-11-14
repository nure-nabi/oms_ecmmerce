import 'package:equatable/equatable.dart';

abstract class ProductSearchEvent extends Equatable{}

class ProductSearchReqEvent extends ProductSearchEvent{
  String productName;
  int limit;
  int offset;
  ProductSearchReqEvent({required this.productName,required this.limit,required this.offset});
  @override
  List<Object?> get props => [productName,limit,offset];
}

class ProductSearchReqClearEvent extends ProductSearchEvent{
  @override
  List<Object?> get props => [];
}