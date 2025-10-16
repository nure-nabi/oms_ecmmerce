import 'package:equatable/equatable.dart';

abstract class ProductLatestEvent extends Equatable{}

class ProductLatestReqEvent extends ProductLatestEvent{
  @override
  List<Object?> get props => [];
}

class ProductLatestWishListFlagReqEvent extends ProductLatestEvent{
  bool flag;
  int index;
  ProductLatestWishListFlagReqEvent({required this.flag, required this.index});
  @override
  List<Object?> get props => [];
}

