import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/compain_bloc/complain_event.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/compain_bloc/complain_state.dart';
import 'package:oms_ecommerce/screen/privacy_policy/model/privacy_policy_model.dart';

import '../../api/privacy_policy_repo.dart';

class ComplainBloc extends Bloc<ComplainEvent, ComplainState> {
  ComplainBloc() : super(ComplainInitialState()) {
    on<ComplainReqEvent>(_onComplainReqEvent);
  }

  Future<void> _onComplainReqEvent(
      ComplainReqEvent event,
      Emitter<ComplainState> omit
      ) async {

    try{

      BasicModel basicModel = await PrivacyPolicyRepo.saveComplain(
          name: event.name,
          email: event.email,
          city: event.city,
          phone: event.phone,
          remarks: event.remark,
          imagePath: event.imagePath);

      if (basicModel.success!) {
        omit(ComplainLoadedState(basicModel: basicModel));
      }else{
        omit(ComplainErrorState(errorMsg: "Please filled all field!"));
      }

    }catch(e){
      omit(ComplainErrorState(errorMsg: e.toString()));
    }
  }
}
