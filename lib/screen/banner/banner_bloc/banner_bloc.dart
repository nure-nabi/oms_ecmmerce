import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/banner/api/banner_repo.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/banner_event.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/banner_state.dart';
import 'package:oms_ecommerce/screen/banner/model/banner_res_model.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerResModel? resModel;

  BannerBloc() : super(BannerInitialState()) {
    on<BannerReqEvent>(_onBannerReqEvent);
  }

  Future<void> _onBannerReqEvent(
    BannerReqEvent event,
    Emitter<BannerState> emit,
  ) async {
    if (resModel == null) {
     // emit(BannerLoadingState());
      resModel = await BannerRepo.getBanner();
    }

    emit(BannerLoadedState(bannerResModel: resModel));
  }
}
