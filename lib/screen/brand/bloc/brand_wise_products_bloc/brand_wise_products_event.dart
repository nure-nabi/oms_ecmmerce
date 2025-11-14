

import 'package:equatable/equatable.dart';

abstract class BrandWiseProductsEvent extends Equatable{}


class BrandWiseProductsReqEvent extends BrandWiseProductsEvent{
  int limit ;
  int offset;
  int brandId;
  BrandWiseProductsReqEvent({required this.limit, required this.offset,required this.brandId});
  @override
  List<Object?> get props => [limit,offset,brandId];
}

class BrandWiseProductsLazyLoadEvent extends BrandWiseProductsEvent{
  int limit ;
  int offset;
  int brandId;
  BrandWiseProductsLazyLoadEvent({required this.limit, required this.offset,required this.brandId});
  @override
  List<Object?> get props => [limit,offset,brandId];
}

class BrandWiseProductsWishListFlagReqEvent extends BrandWiseProductsEvent{
  bool flag;
  int index;
  int brandId;
  BrandWiseProductsWishListFlagReqEvent({required this.flag, required this.index,required this.brandId});
  @override
  List<Object?> get props => [flag,index,brandId];
}

