

import 'package:equatable/equatable.dart';

abstract class TopCategoryProductsEvent extends Equatable{}


class TopCategoryProductsReqEvent extends TopCategoryProductsEvent{
  int limit ;
  int offset;
  int categoryId;
  TopCategoryProductsReqEvent({required this.limit, required this.offset,required this.categoryId});
  @override
  List<Object?> get props => [limit,offset,categoryId];
}

class TopCategoryProductsLazyLoadEvent extends TopCategoryProductsEvent{
  int limit ;
  int offset;
  int categoryId;
  TopCategoryProductsLazyLoadEvent({required this.limit, required this.offset,required this.categoryId});
  @override
  List<Object?> get props => [limit,offset,categoryId];
}
class TopCategoryProductsWishListFlagReqEvent extends TopCategoryProductsEvent{
  bool flag;
  int index;
  TopCategoryProductsWishListFlagReqEvent({required this.flag, required this.index});
  @override
  List<Object?> get props => [flag,index];
}

