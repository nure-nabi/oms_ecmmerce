

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

