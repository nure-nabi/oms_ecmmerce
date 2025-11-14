

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/brand/api/brand_repo.dart';

import 'package:oms_ecommerce/screen/top_category/model/top_category_product_model.dart';
import '../api/top_category_product_repo.dart';
import 'top_category_product_event.dart';
import 'top_category_product_state.dart';


class TopCategoryProductsBloc extends Bloc<TopCategoryProductsEvent, TopCategoryProductsState> {
  TopCategoryProductResModel? resModel;
  TopCategoryProductsBloc() : super(TopCategoryProductsInitialState()) {
    on<TopCategoryProductsReqEvent>(_onBrandWiseProductsReqEvent);
    on<TopCategoryProductsLazyLoadEvent>(_onBrandWiseProductsLazyLoadEvent);
    on<TopCategoryProductsWishListFlagReqEvent>(_onWishlistFlagUpdate);

  }

  Future<void> _onBrandWiseProductsReqEvent(
      TopCategoryProductsReqEvent event,
      Emitter<TopCategoryProductsState> emit,
      ) async {
   // if (state is! BrandWiseProductsEmptyState) return;
    emit(TopCategoryProductsLoadingState(listLoading: 20)); // Show loading with 20 items

    try {
       resModel = await TopCategoryProductRepo.getAllTopCategory(
        limit: event.limit,
        offset: event.offset,
        categoryId: event.categoryId,
      );
      if (resModel!.products.isEmpty) {
        emit(TopCategoryProductsEmptyState());
      } else {
        emit(TopCategoryProductsLoadedState(
          product: resModel!.products,
          hasMore: resModel!.products.length >= event.limit,
          listLoading: 20,
        ));
      }

      // if (resModel.products.isNotEmpty) {
      //   Fluttertoast.showToast(msg: resModel.products.length.toString());
      //   emit(BrandLoadedState(
      //     product: resModel.products,
      //     hasMore: resModel.products.length >= event.limit,
      //     listLoading: 20,
      //   ));
      // } else {
      //   emit(BrandProductListEmptyState());
      // }
    } catch (e) {
      emit(TopCategoryProductsErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _onBrandWiseProductsLazyLoadEvent(
      TopCategoryProductsLazyLoadEvent event,
      Emitter<TopCategoryProductsState> emit,
      ) async {
    // Don't load more if we're already loading or have no more items
    if (state is! TopCategoryProductsLoadedState || !(state as TopCategoryProductsLoadedState).hasMore!) {
      return;
    }

    final currentState = state as TopCategoryProductsLoadedState;
    final nextOffset = currentState.product!.length;

    try {
      // Show loading while keeping current items
      emit(currentState.copyWith(isLoadingMore: true));

      final resModel = await BrandRepo.getAllBrandProduct(
        limit: event.limit,
        offset: nextOffset,
        brandId: event.categoryId,
      );

      if (resModel.products.isNotEmpty) {
        List<TopCategoryModel> newProducts = [
          ...currentState.product!,
          ...resModel.products
        ];
        // product.addAll(resModel.products);
        emit(TopCategoryProductsLoadedState(
          product: newProducts,
          hasMore: resModel.products.length >= event.limit,
          listLoading: currentState.listLoading,
        ));
        // Fluttertoast.showToast(msg: "Loaded ${newProducts.length} items");
      } else {
        // No more items to load
        emit(currentState.copyWith(hasMore: false));
      }
    } catch (e) {
      emit(TopCategoryProductsErrorState(
        errorMsg: e.toString(),
        product: currentState.product,
      ));
      Fluttertoast.showToast(msg: "Error loading more: ${e.toString()}");
    }
  }

  Future<void> _onWishlistFlagUpdate(
      TopCategoryProductsWishListFlagReqEvent event,
      Emitter<TopCategoryProductsState> emit,
      ) async {
    if (resModel == null) return;
    try {
      List<TopCategoryModel> newProduct = List.from(resModel!.products);
      newProduct[event.index] = newProduct[event.index].copyWith(
        is_wishlisted: event.flag,
      );
      emit((state as TopCategoryProductsLoadedState).copyWith(product: newProduct));
    } catch (e) {
      // debugPrint('Error updating wishlist: $e');
    }
  }
}
