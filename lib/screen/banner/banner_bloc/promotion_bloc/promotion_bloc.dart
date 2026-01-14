import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/banner/api/banner_repo.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/banner_event.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/banner_state.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/promotion_bloc/promotion_event.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/promotion_bloc/promotion_state.dart';
import 'package:oms_ecommerce/screen/banner/model/banner_res_model.dart';

import '../../model/promotion_res_model.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  PromotionRes? resModel;

  PromotionBloc() : super(PromotionInitialState()) {
    on<PromotionReqEvent>(_onPromotionReqEvent);
  }

  Future<void> _onPromotionReqEvent(
      PromotionReqEvent event,
    Emitter<PromotionState> emit,
  ) async {
    if (resModel == null) {
      emit(PromotionLoadingState());
      resModel = await BannerRepo.getPromotion();
    }

    emit(PromotionLoadedState(promotionRes: resModel));
  }
}
