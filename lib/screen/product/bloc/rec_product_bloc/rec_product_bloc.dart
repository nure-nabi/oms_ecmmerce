import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/screen/product/api/product_repo.dart';
import 'package:oms_ecommerce/screen/product/bloc/rec_product_bloc/rec_product_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/rec_product_bloc/rec_product_state.dart';
import 'package:oms_ecommerce/screen/product/model/recommended_product_model.dart';

class RecProductBloc extends Bloc<RecProductEvent,RecProductState>{
  RecProductBloc(): super(RecProductInitialState()){
    on<RecProductReqEvent>((event,emit) async{

      emit(RecProductLoadingState());

      try{
      RecommendedProductResModel recommendedProductResModel = await ProductRepo.getProductRecommended();
      emit(RecProductLoadedState(recommendedProductResModel: recommendedProductResModel));
      }catch(e){
        emit(RecProductErrorState(errorMsg: e.toString()));
      }

    });
  }
}