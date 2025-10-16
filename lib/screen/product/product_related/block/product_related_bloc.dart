import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/product/product_related/api/product_related_api.dart';
import 'package:oms_ecommerce/screen/product/product_related/block/product_related_event.dart';
import 'package:oms_ecommerce/screen/product/product_related/block/product_related_state.dart';
import 'package:oms_ecommerce/screen/product/product_related/model/product_related_model.dart';

class ProductRelatedBloc extends Bloc<ProductRelatedEvent,ProductRelatedState>{
  ProductRelatedBloc() : super(ProductRelatedInitialState()){
    on<ProductRelatedReqEvent>((event,emit) async{

      emit(ProductRelatedLoadingState());

     try{
       ProductRelatedResModel relatedResModel = await ProductRelatedRepo.getProductRelated(
           productCode: event.productCode);
       if(relatedResModel.success){
         emit(ProductRelatedLoadedState(productRelatedResModel: relatedResModel));
       }

     }catch(e){emit(ProductRelatedErrorState(errorMsg: e.toString()));
     }

    });
  }
}