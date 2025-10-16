

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/product/api/product_repo.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_state.dart';

import '../../model/latest_product_model.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {

 late LatestProductResModel productResModel;
  List<bool> wishListFlag= [];
  ProductListBloc() : super(ProductListInitialState()) {
    on<ProductListReqEvent>(_onProductListReqEvent);
    on<ProductListLazyLoadEvent>(_onProductListLazyLoadEvent);
    on<ProductWishListUpdateEvent>(_onProductWishListUpdateEvent);
  }

  Future<void> _onProductListReqEvent(
      ProductListReqEvent event,
      Emitter<ProductListState> emit,
      ) async {
  //  emit(ProductListLoadingState(listLoading: 20)); // Show loading with 20 items
   //    List<bool> wishListFlag;
    try {
      productResModel = await ProductRepo.getAllProduct(
        limit: event.limit,
        offset: event.offset,
      );

      wishListFlag = List.generate(productResModel.products.length,
          (index) => productResModel.products[index].is_wishlisted ?? false);

      if (productResModel.products.isNotEmpty) {
        emit(ProductListLoadedState(
          product: productResModel.products,
          hasMore: productResModel.products.length >= event.limit,
          listLoading: 20,
          wishListFlag: wishListFlag,
        ));
      } else {
        emit(ProductListEmptyState());
      }
    } catch (e) {
      emit(ProductListErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _onProductListLazyLoadEvent(
      ProductListLazyLoadEvent event,
      Emitter<ProductListState> emit,
      ) async {
    // Don't load more if we're already loading or have no more items
    if (state is! ProductListLoadedState ||
        !(state as ProductListLoadedState).hasMore) {
      return;
    }

    final currentState = state as ProductListLoadedState;
    final nextOffset = currentState.product.length;

    try {
      // Show loading while keeping current items
      emit(currentState.copyWith(isLoadingMore: true));

      productResModel = await ProductRepo.getAllProduct(
        limit: event.limit,
        offset: nextOffset,
      );

      if (productResModel.products.isNotEmpty) {
        List<LatestProductModel> newProducts = [...currentState.product, ...productResModel.products];
       // product.addAll(resModel.products);
        wishListFlag = List.generate(newProducts.length,
                (index) => newProducts[index].is_wishlisted ?? false);
        emit(ProductListLoadedState(
          product: newProducts,
          hasMore: productResModel.products.length >= event.limit,
          listLoading: currentState.listLoading,
          wishListFlag: wishListFlag,
        ));
       // Fluttertoast.showToast(msg: "Loaded ${newProducts.length} items");
      } else {
        // No more items to load
        emit(currentState.copyWith(hasMore: false));
      }
    } catch (e) {
      emit(ProductListErrorState(
        errorMsg: e.toString(),
        product: currentState.product,
      ));
      Fluttertoast.showToast(msg: "Error loading more: ${e.toString()}");
    }
  }

  Future<void> _onProductWishListUpdateEvent(
      ProductWishListUpdateEvent event,
      Emitter<ProductListState> emit,
      )async{

    if(productResModel == null) return;

    final currentState = state as ProductListLoadedState;
    final nextOffset = currentState.product.length;
    try{

      productResModel = await ProductRepo.getAllProduct(
        limit: event.limit,
        offset: nextOffset,
      );
      List<LatestProductModel> newProducts = [...currentState.product, ...productResModel.products];
      wishListFlag = List.generate(newProducts.length,
              (index) => newProducts[index].is_wishlisted ?? false);
      wishListFlag[event.index] = event.flag;
      newProducts[event.index].is_wishlisted = event.flag;
      emit(ProductListLoadedState(
          product: newProducts,
          listLoading: currentState.listLoading,
          wishListFlag: wishListFlag));

    }catch(e){
      emit(ProductListErrorState(errorMsg: e.toString()));
    }

    }
}




// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:oms_ecommerce/screen/product/api/product_repo.dart';
// import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_event.dart';
// import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_state.dart';
//
// import '../../model/latest_product_model.dart';
//
// class ProductListBloc extends Bloc<ProductListEvent,ProductListState>{
//   ProductListBloc() : super(ProductListInitialState()){
//     LatestProductResModel resModel;
//     int listLoading=0;
//     List<LatestProductModel> product = [];
//     int _limit = 10;
//     int _offset = 0;
//     bool _isLoading = false;
//     bool _hasMore = true;
//     on<ProductListReqEvent>((event, omit)async{
//       omit(ProductListLoadingState()); // Show loading
//        try{
//          listLoading = 0;
//          listLoading = 20;
//          resModel= await ProductRepo.getAllProduct(limit: event.limit, offset: event.offset);
//          if(resModel.products.isNotEmpty && resModel.products != ""){
//            product.addAll(resModel.products);
//
//            omit(ProductListLoadedState(product: product,listLoading: listLoading));
//          }
//        }catch(e){
//          omit(ProductListErrorState(errorMsg: e.toString()));
//        }
//     });
//
//     on<ProductListLazyLoadEvent>((event, omit)async{
//      try{
//        // omit(ProductListInitialState());
//        _offset += event.limit;
//        resModel= await ProductRepo.getAllProduct(limit: event.limit, offset: _offset);
//        //  if(resModel.products.isNotEmpty && resModel.products != ""){
//        product.addAll(resModel.products);
//
//      //  omit(ProductListLoadedState(product: product));
//        omit((state as ProductListLoadedState).copyWith(product: product));
//        Fluttertoast.showToast(msg: product.length.toString());
//
//      }catch(e){
//        Fluttertoast.showToast(msg: "error");
//        omit(ProductListErrorState(errorMsg: e.toString()));
//      }
//
//     });
//
//   }
// }