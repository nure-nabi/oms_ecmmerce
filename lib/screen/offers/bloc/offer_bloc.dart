import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/privacy_policy/api/privacy_policy_repo.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_event.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_state.dart';
import 'package:oms_ecommerce/storage/hive_storage.dart';

import '../api/offer_repo.dart';
import '../model/offer_model.dart';
import 'offer_event.dart';
import 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent,OfferState>{
  OfferBloc() : super(OfferInitialState()){

    on<OfferReqEvent>((event,omit)async{

      try{

        OfferResp offerResp = await OfferRepo.getOffer();
        if(offerResp.success = true){
         // Fluttertoast.showToast(msg: offerResp.data.length.toString());
          HiveStorage.add(UserKey.offerActive.name, offerResp.data[0].is_active.toString());
          HiveStorage.add(UserKey.offerImage.name, offerResp.data[0].offer_image_full_url!);
          omit(OfferLoadedState(offerResp: offerResp));
        }else{
          Fluttertoast.showToast(msg: "No data available");
        }

      }catch (e){
       // Fluttertoast.showToast(msg: e.toString());
        omit(OfferErrorState(errorMsg: e.toString()));
      }

    });

  }
}