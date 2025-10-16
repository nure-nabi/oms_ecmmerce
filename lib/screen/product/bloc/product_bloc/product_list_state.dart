import '../../model/latest_product_model.dart';

abstract class ProductListState {
  const ProductListState();
}

class ProductListInitialState extends ProductListState {}

class ProductListLoadingState extends ProductListState {
  final int listLoading;
  const ProductListLoadingState({required this.listLoading});
}

class ProductListLoadedState extends ProductListState {
  final List<LatestProductModel> product;
  final bool hasMore;
  final bool isLoadingMore;
  final int listLoading;
 final List<bool> wishListFlag;

  const ProductListLoadedState({
    required this.product,
    this.hasMore = true,
    this.isLoadingMore = false,
    required this.listLoading,
    required this.wishListFlag,
  });

  ProductListLoadedState copyWith({
    List<LatestProductModel>? product,
     List<bool>? wishListFlag,
    bool? hasMore,
    bool? isLoadingMore,
    int? listLoading,
  }) {
    return ProductListLoadedState(
      product: product ?? this.product,
      wishListFlag: wishListFlag ?? this.wishListFlag,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      listLoading: listLoading ?? this.listLoading,
    );
  }
}

class ProductListErrorState extends ProductListState {
  final String errorMsg;
  final List<LatestProductModel>? product;
  const ProductListErrorState({required this.errorMsg, this.product});
}

class ProductListEmptyState extends ProductListState {}