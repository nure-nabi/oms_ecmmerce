import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/category/api/category_repo.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_event.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_state.dart';
import 'package:oms_ecommerce/screen/category/model/category_model.dart';

import '../../model/category_product_model.dart';
import 'category_product_event.dart';
import 'category_product_state.dart';

class CategoryProductBloc extends Bloc<CategoryProductEvent, CategoryProductState> {
  CategoryProductResModel? resModel;
  CategoryProductBloc() : super(CategoryProductsInitialState()) {
    on<CategoryProductsReqEvent>(_onCategoryProductsReqEvent);
    on<CategoryProductsLazyLoadEvent>(_onCategoryProductsLazyLoadEvent);
    on<CategoryProductsWishListFlagReqEvent>(_onWishlistFlagUpdate);

  }

  Future<void> _onCategoryProductsReqEvent(
      CategoryProductsReqEvent event,
      Emitter<CategoryProductState> emit,
      ) async {
    // if (state is! BrandWiseProductsEmptyState) return;
   // emit(CategoryProductsLoadedState(listLoading: 20)); // Show loading with 20 items

    try {
     // emit(CategoryProductsLoadingState(listLoading: 20));
       resModel = await CategoryRepo.getCategoryProduct(
        limit: event.limit,
        offset: event.offset,
        categoryId: event.categoryId,
      );

      if (resModel!.products.isEmpty) {
        emit(CategoryProductsEmptyState());
      } else {
        emit(CategoryProductsLoadedState(
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
      emit(CategoryProductsErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _onCategoryProductsLazyLoadEvent(
      CategoryProductsLazyLoadEvent event,
      Emitter<CategoryProductState> emit,
      ) async {
    // Don't load more if we're already loading or have no more items
    if (state is! CategoryProductsLoadedState || !(state as CategoryProductsLoadedState).hasMore!) {
      return;
    }

    final currentState = state as CategoryProductsLoadedState;
    final nextOffset = currentState.product!.length;

    try {
      // Show loading while keeping current items
      emit(currentState.copyWith(isLoadingMore: true));

      resModel =await CategoryRepo.getCategoryProduct(
        limit: event.limit,
        offset: nextOffset,
        categoryId: event.categoryId,
      );

      if (resModel!.products.isNotEmpty) {
        List<CategoryProductModel> newProducts = [
          ...currentState.product!,
          ...resModel!.products
        ];
        // product.addAll(resModel.products);
        emit(CategoryProductsLoadedState(
          product: newProducts,
          hasMore: resModel!.products.length >= event.limit,
          listLoading: currentState.listLoading,
        ));
        // Fluttertoast.showToast(msg: "Loaded ${newProducts.length} items");
      } else {
        // No more items to load
        emit(currentState.copyWith(hasMore: false));
      }
    } catch (e) {
      emit(CategoryProductsErrorState(
        errorMsg: e.toString(),
        product: currentState.product,
      ));
      Fluttertoast.showToast(msg: "Error loading more: ${e.toString()}");
    }
  }

  Future<void> _onWishlistFlagUpdate(
      CategoryProductsWishListFlagReqEvent event,
      Emitter<CategoryProductState> emit,
      ) async {
    if (resModel == null) return;
    try {
      List<CategoryProductModel> newProduct = List.from(resModel!.products);
      newProduct[event.index] = newProduct[event.index].copyWith(
        is_wishlisted: event.flag,
      );
      emit((state as CategoryProductsLoadedState).copyWith(product: newProduct));
    } catch (e) {
      // debugPrint('Error updating wishlist: $e');
    }
  }
}