import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable{}

class ProductListReqEvent extends ProductListEvent{
  int limit ;
  int offset;
  ProductListReqEvent({required this.limit, required this.offset});
  @override
  List<Object?> get props => [limit,offset];
}

class ProductListLazyLoadEvent extends ProductListEvent{
  int limit ;
  int offset;
  ProductListLazyLoadEvent({required this.limit, required this.offset});
  @override
  List<Object?> get props => [limit,offset];
}

class ProductWishListUpdateEvent extends ProductListEvent{
  int index;
  bool flag;
  int limit;
  ProductWishListUpdateEvent({required this.index, required this.flag, required this.limit});
  @override
  List<Object?> get props => [index,flag,limit];
}