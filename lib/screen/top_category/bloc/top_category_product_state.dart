
import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/brand/model/brand_model.dart';
import 'package:oms_ecommerce/screen/top_category/model/top_category_product_model.dart';


abstract class TopCategoryProductsState extends Equatable{}

class TopCategoryProductsInitialState extends TopCategoryProductsState{
  @override
  List<Object?> get props => [];
}

class TopCategoryProductsLoadingState extends TopCategoryProductsState{
  final int listLoading;
  TopCategoryProductsLoadingState({required this.listLoading});
  @override
  List<Object?> get props => [listLoading];
}

class TopCategoryProductsLoadedState extends TopCategoryProductsState{
  final BrandResponse? brandResponse;
  final List<BrandModel>? brandLists;
  final List<TopCategoryModel>? product;
  final bool? hasMore;
  final bool? isLoadingMore;
  final int? listLoading;
  TopCategoryProductsLoadedState({this.brandResponse,this.brandLists, this.product,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.listLoading,});

  TopCategoryProductsLoadedState copyWith({
    BrandResponse? brandResponse,
    List<BrandModel>? brandLists,
    List<TopCategoryModel>? product,
    bool? hasMore,
    bool? isLoadingMore,
    int? listLoading,
  }) {
    return TopCategoryProductsLoadedState(
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

class TopCategoryProductsErrorState extends TopCategoryProductsState{
  String errorMsg;
  final List<TopCategoryModel>? product;
  TopCategoryProductsErrorState({required this.errorMsg, this.product});
  @override
  List<Object?> get props => [errorMsg,product];
}

class TopCategoryProductsEmptyState extends TopCategoryProductsState {
  @override
  List<Object?> get props => [];
}