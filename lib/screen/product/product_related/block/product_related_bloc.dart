import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/product/product_related/api/product_related_api.dart';
import 'package:oms_ecommerce/screen/product/product_related/block/product_related_event.dart';
import 'package:oms_ecommerce/screen/product/product_related/block/product_related_state.dart';
import 'package:oms_ecommerce/screen/product/product_related/model/product_related_model.dart';

class ProductRelatedBloc extends Bloc<ProductRelatedEvent,ProductRelatedState>{
  ProductRelatedResModel? relatedResModel;
  List<bool> wishListFlag = [];
  ProductRelatedBloc() : super(ProductRelatedInitialState()){
    on<ProductRelatedReqEvent>((event,emit) async{
      emit(ProductRelatedLoadingState());
     try{
        relatedResModel = await ProductRelatedRepo.getProductRelated(
           productCode: event.productCode);
        // Initialize wishlist flags
        wishListFlag = List.generate(
          relatedResModel!.data.length,
              (index) =>
              relatedResModel!.data[index].is_wishlisted ?? false,);
       if(relatedResModel!.success){
         emit(ProductRelatedLoadedState(productRelatedResModel: relatedResModel));
       }
     }catch(e){emit(ProductRelatedErrorState(errorMsg: e.toString()));
     }
    });

    on<ProductRelatedWishListFlagReqEvent>((event,emit) async{
      if (relatedResModel == null) return;

      try {
        emit(ProductRelatedLoadingState());
        // Update local state immediately for better UX
        wishListFlag[event.index] = event.flag;
        // Update the model to reflect the change
        relatedResModel!.data[event.index].is_wishlisted = event.flag;
        // If you need to sync with server, call API here
        // await ProductRepo.updateWishlistStatus(productId, event.flag);
       // Fluttertoast.showToast(msg: relatedResModel!.data[event.index].is_wishlisted.toString());
        emit(ProductRelatedLoadedState(
          productRelatedResModel: relatedResModel,
          wishListFlag: wishListFlag,
        ));
      } catch (e) {
        // Revert the change if API call fails
        wishListFlag[event.index] = !event.flag;
        relatedResModel!.data[event.index].is_wishlisted = !event.flag;
        emit(ProductRelatedErrorState(
          errorMsg: 'Failed to update wishlist',
          productRelatedResModel: relatedResModel,
          wishListFlag: wishListFlag,
        ));
      }
    });
  }
}