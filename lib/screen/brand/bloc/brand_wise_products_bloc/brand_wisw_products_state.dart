
import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/brand/model/brand_model.dart';
import '../../model/brand_product_model.dart';

abstract class BrandWiseProductsState extends Equatable{}

class BrandWiseProductsInitialState extends BrandWiseProductsState{
  @override
  List<Object?> get props => [];
}

class BrandWiseProductsLoadingState extends BrandWiseProductsState{
  final int listLoading;
  BrandWiseProductsLoadingState({required this.listLoading});
  @override
  List<Object?> get props => [listLoading];
}

class BrandWiseProductsLoadedState extends BrandWiseProductsState{
  final BrandResponse? brandResponse;
  final List<BrandModel>? brandLists;
  final List<BrandProductModel>? product;
  final bool? hasMore;
  final bool? isLoadingMore;
  final int? listLoading;
  BrandWiseProductsLoadedState({this.brandResponse,this.brandLists, this.product,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.listLoading,});

  BrandWiseProductsLoadedState copyWith({
    BrandResponse? brandResponse,
    List<BrandModel>? brandLists,
    List<BrandProductModel>? product,
    bool? hasMore,
    bool? isLoadingMore,
    int? listLoading,
  }) {
    return BrandWiseProductsLoadedState(
      brandResponse: brandResponse ?? this.brandResponse,
      brandLists: brandLists ?? this.brandLists,
      product: product ?? this.product,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      listLoading: listLoading ?? this.listLoading,
    );
  }
  @override
  List<Object?> get props => [brandResponse];
}

class BrandWiseProductsErrorState extends BrandWiseProductsState{
  String errorMsg;
  final List<BrandProductModel>? product;
  BrandWiseProductsErrorState({required this.errorMsg, this.product});
  @override
  List<Object?> get props => [errorMsg,product];
}

class BrandWiseProductsEmptyState extends BrandWiseProductsState {
  @override
  List<Object?> get props => [];
}