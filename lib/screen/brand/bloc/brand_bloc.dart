import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/brand/api/brand_repo.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_event.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_state.dart';
import 'package:oms_ecommerce/screen/brand/model/brand_model.dart';

import '../model/brand_product_model.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandResponse? response;
  BrandBloc() : super(BrandInitialState()) {
    on<BrandReqEvent>(_onBrandReqEvent);
  }

  Future<void> _onBrandReqEvent(
    BrandReqEvent event,
    Emitter<BrandState> emit,
  ) async {

    if (response == null) {
    //  emit(BrandLoadingState());
     response = await BrandRepo.getBrand();
    }
    if (response!.success == true) {
      emit(BrandLoadedState(brandResponse: response));
    } else {
      emit(BrandErrorState(errorMsg: "Failed to load brands"));
    }
  }
}
