import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/search_product/bloc/search_product_event.dart';
import 'package:oms_ecommerce/screen/search_product/bloc/search_product_state.dart';

import '../api/search_product_repo.dart';
import '../model/search_product_model.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  SearchProductResp? searchProductResp;
  ProductSearchBloc() : super(ProductSearchInitialState()) {
    on<ProductSearchReqEvent>(_onProductSearchReqEvent);
    on<ProductSearchReqClearEvent>(_onProductSearchReqClearEvent);
  }

  Future<void> _onProductSearchReqEvent(
    ProductSearchReqEvent event,
    Emitter<ProductSearchState> emit,
  ) async {
    try{
       searchProductResp =
      await SearchProductRepo.getSearchProduct(
        productName: event.productName,
        limit: event.limit,
        offset: event.offset,
      );
      if(searchProductResp!.success){
        emit(ProductSearchLoadedState(searchProductResp:searchProductResp!));
      }else{
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      emit(ProductSearchErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _onProductSearchReqClearEvent(
      ProductSearchReqClearEvent event,
      Emitter<ProductSearchState> emit,
      ) async {
     searchProductResp = null;
    emit(ProductSearchInitialState());
  }
}
