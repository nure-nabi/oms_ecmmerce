

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/brand/api/brand_repo.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_event.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_state.dart';

import 'package:oms_ecommerce/screen/brand/model/brand_model.dart';

import '../../model/brand_product_model.dart';

import 'brand_wise_products_event.dart';
import 'brand_wisw_products_state.dart';


class BrandWiseProductsBloc extends Bloc<BrandWiseProductsEvent, BrandWiseProductsState> {
  BrandWiseProductsBloc() : super(BrandWiseProductsInitialState()) {
    on<BrandWiseProductsReqEvent>(_onBrandWiseProductsReqEvent);
    on<BrandWiseProductsLazyLoadEvent>(_onBrandWiseProductsLazyLoadEvent);

  }

  Future<void> _onBrandWiseProductsReqEvent(
      BrandWiseProductsReqEvent event,
      Emitter<BrandWiseProductsState> emit,
      ) async {
   // if (state is! BrandWiseProductsEmptyState) return;
    emit(BrandWiseProductsLoadingState(listLoading: 20)); // Show loading with 20 items

    try {
      final resModel = await BrandRepo.getAllBrandProduct(
        limit: event.limit,
        offset: event.offset,
        brandId: event.brandId,
      );
      if (resModel.products.isEmpty) {
        emit(BrandWiseProductsEmptyState());
      } else {
        emit(BrandWiseProductsLoadedState(
          product: resModel.products,
          hasMore: resModel.products.length >= event.limit,
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
      emit(BrandWiseProductsErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _onBrandWiseProductsLazyLoadEvent(
      BrandWiseProductsLazyLoadEvent event,
      Emitter<BrandWiseProductsState> emit,
      ) async {
    // Don't load more if we're already loading or have no more items
    if (state is! BrandWiseProductsLoadedState || !(state as BrandWiseProductsLoadedState).hasMore!) {
      return;
    }

    final currentState = state as BrandWiseProductsLoadedState;
    final nextOffset = currentState.product!.length;

    try {
      // Show loading while keeping current items
      emit(currentState.copyWith(isLoadingMore: true));

      final resModel = await BrandRepo.getAllBrandProduct(
        limit: event.limit,
        offset: nextOffset,
        brandId: event.brandId,
      );

      if (resModel.products.isNotEmpty) {
        List<BrandProductModel> newProducts = [
          ...currentState.product!,
          ...resModel.products
        ];
        // product.addAll(resModel.products);
        emit(BrandWiseProductsLoadedState(
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
      emit(BrandWiseProductsErrorState(
        errorMsg: e.toString(),
        product: currentState.product,
      ));
      Fluttertoast.showToast(msg: "Error loading more: ${e.toString()}");
    }
  }
}
