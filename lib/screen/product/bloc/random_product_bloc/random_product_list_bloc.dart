

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/product/api/product_repo.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_state.dart';
import 'package:oms_ecommerce/screen/product/bloc/random_product_bloc/random_product_list_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/random_product_bloc/random_product_list_state.dart' hide ProductListInitialState;

import '../../model/latest_product_model.dart';
import '../../model/random_product_model.dart';

class RandomProductListBloc extends Bloc<RandomProductListEvent, RandomProductListState> {

 late RandomProductRes productResModel;
  List<bool> wishListFlag= [];
 RandomProductListBloc() : super(RandomProductListInitialState()) {
    on<RandomProductListReqEvent>(_onRandomProductListReqEvent);
   // on<RandomProductListLazyLoadEvent>(_onRandomProductListLazyLoadEvent);
   // on<ProductWishListUpdateEvent>(_onProductWishListUpdateEvent);
    on<RandomProductWishListUpdateEvent>(_onRandomProductWishListUpdateEvent);
  }

  Future<void> _onRandomProductListReqEvent(
      RandomProductListReqEvent event,
      Emitter<RandomProductListState> emit,
      ) async {
  //  emit(ProductListLoadingState(listLoading: 20)); // Show loading with 20 items
   //    List<bool> wishListFlag;
    try {
      productResModel = await ProductRepo.getAllRandomProduct();

      wishListFlag = List.generate(productResModel.products.length,
          (index) => productResModel.products[index].is_wishlisted ?? false);

      if (productResModel.products.isNotEmpty) {
        emit(RandomProductListLoadedState(
          product: productResModel.products,
          wishListFlag: wishListFlag,
        ));
      } else {
        emit(RandomProductListEmptyState());
      }
    } catch (e) {
      emit(RandomProductListErrorState(errorMsg: e.toString()));
    }
  }



  Future<void> _onRandomProductWishListUpdateEvent(
      RandomProductWishListUpdateEvent event,
      Emitter<RandomProductListState> emit,
      )async{

    if(productResModel == null) return;

    final currentState = state as ProductListLoadedState;
    final nextOffset = currentState.product.length;
    try{

      productResModel = await ProductRepo.getAllProduct(
        limit: event.limit,
        offset: nextOffset,
      );

      wishListFlag = List.generate(productResModel.products.length,
              (index) => productResModel.products[index].is_wishlisted ?? false);
      emit(RandomProductListLoadedState(
          product:  productResModel.products,
          wishListFlag: wishListFlag));

    }catch(e){
      emit(RandomProductListErrorState(errorMsg: e.toString()));
    }

    }

 Future<void> _onWishlistFlagUpdate(
     ProductWishListUpdateEvent event,
     Emitter<ProductListState> emit,
     ) async {
   if (productResModel == null) return;
   try {
     List<LatestProductModel> newProduct = List.from(productResModel.products);
     newProduct[event.index] = newProduct[event.index].copyWith(
       is_wishlisted: event.flag,
     );
     emit((state as ProductListLoadedState).copyWith(product: newProduct));
   } catch (e) {
     // debugPrint('Error updating wishlist: $e');
   }
 }
}

