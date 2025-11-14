import 'package:equatable/equatable.dart';

import '../model/search_product_model.dart';

abstract class ProductSearchState extends Equatable{

}

class ProductSearchInitialState extends ProductSearchState{
  @override
  List<Object?> get props =>[];
}
class ProductSearchLoadingState extends ProductSearchState{
  @override
  List<Object?> get props =>[];
}
class ProductSearchLoadedState extends ProductSearchState{
  SearchProductResp searchProductResp;
  ProductSearchLoadedState({required this.searchProductResp});
  @override
  List<Object?> get props =>[searchProductResp];
}
class ProductSearchErrorState extends ProductSearchState{
  String? errorMsg;
  ProductSearchErrorState({this.errorMsg});
  @override
  List<Object?> get props =>[errorMsg];
}