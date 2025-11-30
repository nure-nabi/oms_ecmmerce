import 'package:equatable/equatable.dart';

abstract class CategoryProductEvent extends Equatable{

}

class CategoryProductsReqEvent extends CategoryProductEvent{
  int limit ;
  int offset;
  int categoryId;
  CategoryProductsReqEvent({required this.limit, required this.offset,required this.categoryId});
  @override
  List<Object?> get props => [limit,offset,categoryId];
}

class CategoryProductsLazyLoadEvent extends CategoryProductEvent{
  int limit ;
  int offset;
  int categoryId;
  CategoryProductsLazyLoadEvent({required this.limit, required this.offset,required this.categoryId});
  @override
  List<Object?> get props => [limit,offset,categoryId];
}

class CategoryProductsWishListFlagReqEvent extends CategoryProductEvent{
  bool flag;
  int index;
  int categoryId;
  CategoryProductsWishListFlagReqEvent({required this.flag, required this.index,required this.categoryId});
  @override
  List<Object?> get props => [flag,index,categoryId];
}

