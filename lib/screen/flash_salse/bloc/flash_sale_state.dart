import 'package:equatable/equatable.dart';
import '../../product/bloc/product_bloc/product_list_state.dart';
import '../model/flash_product_model.dart';

abstract class FlashSaleState extends Equatable{
}

class FlashSaleInitialState extends FlashSaleState {
  @override
  List<Object?> get props => [];
}

class FlashSaleLoadingState extends FlashSaleState {
  final int listLoading;
  FlashSaleLoadingState({required this.listLoading});

  @override
  List<Object?> get props => [listLoading];
}

class FlashSaleLoadedState extends FlashSaleState {
  final List<FlashProductModel> product;
  final bool hasMore;
  final bool isLoadingMore;
  final int listLoading;

   FlashSaleLoadedState({
    required this.product,
    this.hasMore = true,
    this.isLoadingMore = false,
    required this.listLoading,
  });

  FlashSaleLoadedState copyWith({
    List<FlashProductModel>? product,
    bool? hasMore,
    bool? isLoadingMore,
    int? listLoading,
  }) {
    return FlashSaleLoadedState(
      product: product ?? this.product,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      listLoading: listLoading ?? this.listLoading,
    );
  }

  @override
  List<Object?> get props => [product,hasMore,isLoadingMore,listLoading];
}

class FlashSalesErrorState extends FlashSaleState {
  final String errorMsg;
  final List<FlashProductModel>? product;
   FlashSalesErrorState({required this.errorMsg, this.product});

  @override
  List<Object?> get props => [errorMsg];
}

class FlashSaleEmptyState extends FlashSaleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}