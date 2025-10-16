import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/address/api/addrees_repo.dart';
import 'package:oms_ecommerce/screen/address/bloc/provience_event.dart';
import 'package:oms_ecommerce/screen/address/bloc/provience_state.dart';
import 'package:oms_ecommerce/screen/address/model/provience_model.dart';

class ProvienceBloc extends Bloc<ProvienceEvent,ProvienceState>{

  ProvienceResModel? resData;
  ProvienceBloc() : super(ProvienceInitialState()){

    on<ProvienceReqEvent>((event,emit) async {
      emit(ProvienceLoadingState());
      try{
         resData = await  AddressRepo.getProvience();
        if(resData!.success == true){
          emit(ProvienceLoadedState(
            provienceRes: resData,
              indexProvience: event.indexProvience,
              provienceValue: event.province,
              cityValue: event.city,
              zoneValues: event.zone,
            indexCity: event.indexCity,
            indexZone: event.indexZone,
          ));
         // Fluttertoast.showToast(msg: "Fetch Data Provience");
        }else{
         // Fluttertoast.showToast(msg: "asdfsadfsdf");
        }
      }catch(e){
        emit(ProvienceErrorState(errorMsg: e.toString()));
      }

    });

    on<ProvienceProvienceIndexEvent>((event,emit){

      emit(ProvienceLoadedState(
          provienceRes: resData,
          indexCity: event.index,
          provienceValue: event.province,
          cityValue: event.city,
          indexProvience: event.index));
    });

    on<ProvienceZoneIndexEvent>((event,emit){


      emit(ProvienceLoadedState(
          provienceRes: resData,
          indexProvience: event.indexProvience,
          indexCity: event.indexcITY,
          indexZone: event.indexZone,
          zoveValue: event.zoneValue,
          zoneValues: event.zoneValue,
          provienceValue: event.province,
          cityValue: event.city));


    });




  }
}