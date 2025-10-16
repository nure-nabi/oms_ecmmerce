import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/privacy_policy/api/privacy_policy_repo.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_event.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_state.dart';

import '../model/privacy_policy_model.dart';

class PrivacyBloc extends Bloc<PrivacyEvent,PrivacyState>{
  PrivacyBloc() : super(PrivacyInitialState()){

    on<PrivacyReqEvent>((event,omit)async{

      try{

        PrivacyPolicyRes privacyPolicyRes = await PrivacyPolicyRepo.getPrivacyPolicy();

        if(privacyPolicyRes.privacyPolicy.isNotEmpty){
          omit(PrivacyLoadedState(privacyPolicyRes: privacyPolicyRes));
        }else{
          Fluttertoast.showToast(msg: "No data available");
        }

      }catch (e){
        omit(PrivacyErrorState(errorMsg: e.toString()));
      }

    });

  }
}