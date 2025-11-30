import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/category/model/category_model.dart';

import '../../../brand/model/brand_model.dart';
import '../../model/category_product_model.dart';

abstract class CategoryProductState extends Equatable {

}

class CategoryProductsInitialState extends CategoryProductState{
  @override
  List<Object?> get props => [];
}

class CategoryProductsLoadingState extends CategoryProductState{
  final int listLoading;
  CategoryProductsLoadingState({required this.listLoading});
  @override
  List<Object?> get props => [listLoading];
}

class CategoryProductsLoadedState extends CategoryProductState{
  final BrandResponse? brandResponse;
  final List<BrandModel>? brandLists;
  final List<CategoryProductModel>? product;
  final bool? hasMore;
  final bool? isLoadingMore;
  final int? listLoading;
  CategoryProductsLoadedState({this.brandResponse,this.brandLists, this.product,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.listLoading,});

  CategoryProductsLoadedState copyWith({
    BrandResponse? brandResponse,
    List<BrandModel>? brandLists,
    List<CategoryProductModel>? product,
    bool? hasMore,
    bool? isLoadingMore,
    int? listLoading,
  }) {
    return CategoryProductsLoadedState(
      brandResponse: brandResponse ?? this.brandResponse,
      brandLists: brandLists ?? this.brandLists,
      product: product ?? this.product,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      listLoading: listLoading ?? this.listLoading,
    );
  }
  @override
  List<Object?> get props => [product, hasMore, listLoading];
}

class CategoryProductsErrorState extends CategoryProductState{
  String errorMsg;
  final List<CategoryProductModel>? product;
  CategoryProductsErrorState({required this.errorMsg, this.product});
  @override
  List<Object?> get props => [errorMsg,product];
}

class CategoryProductsEmptyState extends CategoryProductState {
  @override
  List<Object?> get props => [];
}