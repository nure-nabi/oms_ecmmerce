import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/order/api/order_repo.dart';
import 'package:oms_ecommerce/screen/order/bloc/reason/reason_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/reason/reason_state.dart';

import '../../../../utils/custome_toast.dart';
import '../../../address/model/address_model.dart';
import '../../model/reason_model.dart';

class ReasonBloc extends Bloc<ReasonEvent, ReasonState> {
  ReasonBloc() : super(ReasonInitialState()) {
    on<ReasonReqEven>((event, omit) async {
      //  omit(ReasonLoadingState());
      try {
        ReasonResponse response = await OrderRepo.getReason();
           if(response.success == true){
        omit(ReasonLoadedState(

            reasonResponse: response, policyChecked: event.policyChecked,reasonId: int.parse(event.reasonId!) != null ? int.parse(event.reasonId!) : 1));
        //  omit((state as ReasonLoadedState).copyWith(response,false));
          }
      } catch (e) {
        omit(ReasonErrorState(errorMsg: e.toString()));
      }
    });

    on<ReasonSaveEven>((event, omit) async{
     // omit((state as ReasonLoadedState).copyWith(reasonId: int.parse(event.reasonId!)));
      AddressResponse response = await OrderRepo.reasonSave(
          orderId: event.orderId,
          reasonId: event.reasonId,
          description: event.description,
          check: event.check
      );

      if(response.success == true){
        CustomToast.showCustomRoast(context: event.context!, message: response.message!,
            icon: Bootstrap.check_circle,iconColor: Colors.green);
        Navigator.pushReplacementNamed(event.context!, orderActivityPage);
      }
    });
  }
}