import '../../model/latest_product_model.dart';
import '../../model/random_product_model.dart';

abstract class RandomProductListState {
  const RandomProductListState();
}

class RandomProductListInitialState extends RandomProductListState {}

class RandomProductListLoadingState extends RandomProductListState {
  final int listLoading;
  const RandomProductListLoadingState({required this.listLoading});
}

class RandomProductListLoadedState extends RandomProductListState {
  final List<RandomProductModel> product;
 final List<bool> wishListFlag;

  const RandomProductListLoadedState({
    required this.product,

    required this.wishListFlag,
  });

  RandomProductListLoadedState copyWith({
    List<RandomProductModel>? product,
     List<bool>? wishListFlag,
    bool? hasMore,
    bool? isLoadingMore,
    int? listLoading,
  }) {
    return RandomProductListLoadedState(
      product: product ?? this.product,
      wishListFlag: wishListFlag ?? this.wishListFlag,

    );
  }
}

class RandomProductListErrorState extends RandomProductListState {
  final String errorMsg;
  final List<RandomProductModel>? product;
  const RandomProductListErrorState({required this.errorMsg, this.product});
}

class RandomProductListEmptyState extends RandomProductListState {}