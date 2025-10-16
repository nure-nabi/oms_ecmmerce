import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/product/api/product_repo.dart';
import 'package:oms_ecommerce/screen/product/bloc/ProductLatestEvent.dart';
import 'package:oms_ecommerce/screen/product/bloc/ProductLatestState.dart';
import '../model/latest_product_model.dart';

class ProductLatestBloc extends Bloc<ProductLatestEvent, ProductLatestState> {
  List<bool> wishListFlag = [];
  LatestProductResModel? latestProductResModel;

  ProductLatestBloc() : super(ProductLatestInitialState()) {
    on<ProductLatestReqEvent>(_onProductLatestRequest);
    on<ProductLatestWishListFlagReqEvent>(_onWishlistFlagUpdate);
  }

  Future<void> _onProductLatestRequest(
      ProductLatestReqEvent event,
      Emitter<ProductLatestState> emit,
      ) async {

    try {
      if(latestProductResModel == null){
        emit(ProductLatestLoadingState());
        latestProductResModel = await ProductRepo.getLatestProduct();
        // Initialize wishlist flags
        wishListFlag = List.generate(
          latestProductResModel!.products.length,
              (index) =>
          latestProductResModel!.products[index].is_wishlisted ?? false,);
        emit(ProductLatestLoadedState(
          latestProductResModel: latestProductResModel,
          wishListFlag: wishListFlag,
        ));
      }else {
        latestProductResModel = await ProductRepo.getLatestProduct();
        // Initialize wishlist flags
        wishListFlag = List.generate(
          latestProductResModel!.products.length,
              (index) =>
          latestProductResModel!.products[index].is_wishlisted ?? false,);
        emit(ProductLatestLoadedState(
          latestProductResModel: latestProductResModel,
          wishListFlag: wishListFlag,
        ));
      }
    } catch (e) {
      emit(ProductLatestErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _onWishlistFlagUpdate(
      ProductLatestWishListFlagReqEvent event,
      Emitter<ProductLatestState> emit,
      ) async {
    if (latestProductResModel == null) return;

    try {
      emit(ProductLatestLoadingState());
      // Update local state immediately for better UX
      wishListFlag[event.index] = event.flag;
      // Update the model to reflect the change
      latestProductResModel!.products[event.index].is_wishlisted = event.flag;
      // If you need to sync with server, call API here
      // await ProductRepo.updateWishlistStatus(productId, event.flag);
      emit(ProductLatestLoadedState(
        latestProductResModel: latestProductResModel,
        wishListFlag: wishListFlag,
      ));
    } catch (e) {
      // Revert the change if API call fails
      wishListFlag[event.index] = !event.flag;
      latestProductResModel!.products[event.index].is_wishlisted = !event.flag;
      emit(ProductLatestErrorState(
        errorMsg: 'Failed to update wishlist',
        latestProductResModel: latestProductResModel,
        wishListFlag: wishListFlag,
      ));
    }
  }
}