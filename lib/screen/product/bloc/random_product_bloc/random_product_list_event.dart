import 'package:equatable/equatable.dart';

abstract class RandomProductListEvent extends Equatable{}

class RandomProductListReqEvent extends RandomProductListEvent{
  @override
  List<Object?> get props => [];
}

class RandomProductListLazyLoadEvent extends RandomProductListEvent{
  int limit ;
  int offset;
  RandomProductListLazyLoadEvent({required this.limit, required this.offset});
  @override
  List<Object?> get props => [limit,offset];
}

class RandomProductWishListUpdateEvent extends RandomProductListEvent{
  int index;
  bool flag;
  int limit;
  RandomProductWishListUpdateEvent({required this.index, required this.flag, required this.limit});
  @override
  List<Object?> get props => [index,flag,limit];
}