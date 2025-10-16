import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/flash_salse/api/flash_sale_repo.dart';
import 'package:oms_ecommerce/screen/flash_salse/bloc/flash_sale_event.dart';
import 'package:oms_ecommerce/screen/flash_salse/bloc/flash_sale_state.dart';
import 'package:oms_ecommerce/screen/product/api/product_repo.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_state.dart';

import '../model/flash_product_model.dart';


class FlashSaleBloc extends Bloc<FlashSaleEvent, FlashSaleState> {

  FlashProductResModel? flashProductRes;
  FlashSaleBloc() : super(FlashSaleInitialState()) {
    on<FlashSalesReqEvent>(_onFlashSalesReqEvent);
    on<FlashSalesLazyLoadEvent>(_onFlashSalesLazyLoadEvent);
    on<FlashSalesWishListUpdateEvent>(_onFlashSalesWishListUpdateEvent);
  }

  Future<void> _onFlashSalesReqEvent(
      FlashSalesReqEvent event,
      Emitter<FlashSaleState> emit,
      ) async {
   // Show loading with 20 items

    try {
      if(flashProductRes == null) {
        emit(FlashSaleLoadingState(listLoading: 20));
        flashProductRes = await FlashSaleRepo.getFlashSales(
          limit: event.limit,
          offset: event.offset,
        );
        if (flashProductRes!.products.isNotEmpty) {
          emit(FlashSaleLoadedState(
            product: flashProductRes!.products,
            hasMore: flashProductRes!.products.length >= event.limit,
            listLoading: 20,
          ));
        } else {
          emit(FlashSaleEmptyState());
        }
      }else{
        flashProductRes = await FlashSaleRepo.getFlashSales(
          limit: event.limit,
          offset: event.offset,
        );
        emit(FlashSaleLoadedState(
          product: flashProductRes!.products,
          hasMore: flashProductRes!.products.length >= event.limit,
          listLoading: 20,
        ));
      }

    } catch (e) {
      emit(FlashSalesErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _onFlashSalesLazyLoadEvent(
      FlashSalesLazyLoadEvent event,
      Emitter<FlashSaleState> emit,
      ) async {
    // Don't load more if we're already loading or have no more items
    if (state is! FlashSaleLoadedState ||
        !(state as FlashSaleLoadedState).hasMore) {
      return;
    }

    final currentState = state as FlashSaleLoadedState;
    final nextOffset = currentState.product.length;

    try {
      // Show loading while keeping current items
      emit(currentState.copyWith(isLoadingMore: true));

      final resModel = await FlashSaleRepo.getFlashSales(
        limit: event.limit,
        offset: nextOffset,
      );

      if (resModel.products.isNotEmpty) {
        List<FlashProductModel> newProducts = [...currentState.product, ...resModel.products];
        // product.addAll(resModel.products);
        emit(FlashSaleLoadedState(
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
      emit(FlashSalesErrorState(
        errorMsg: e.toString(),
        product: currentState.product,
      ));
      Fluttertoast.showToast(msg: "Error loading more: ${e.toString()}");
    }
  }

  Future<void> _onFlashSalesWishListUpdateEvent(
      FlashSalesWishListUpdateEvent event,
      Emitter<FlashSaleState> emit
      )async{
      flashProductRes!.products[event.index].is_wishlisted = event.flag;
      emit(FlashSaleLoadedState(product: flashProductRes!.products, listLoading: 20));
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