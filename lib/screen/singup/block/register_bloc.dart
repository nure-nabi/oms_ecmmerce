import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/singup/api/register_repo.dart';
import 'package:oms_ecommerce/screen/singup/block/register_event.dart';
import 'package:oms_ecommerce/screen/singup/block/register_state.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';

import '../../service/sharepref/set_all_pref.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() :super(RegisterInitialState()) {
    on<RegisterReqEvent>((event, emit) async {
     // emit(RegisterLoadingState());

      try {
        RegisterResModel? registerResModel = await RegisterAPI.register(
            firstName: event.registerReqModel?.firstName ?? "",
            lastName: event.registerReqModel?.lastName ?? "",
            password: event.registerReqModel?.password ?? "",
            phone: event.registerReqModel?.phone ?? "",
            email: event.registerReqModel?.email ?? "");
        if(registerResModel!.email!.isNotEmpty){
          emit(RegisterLoadedState(registerResModel: registerResModel));
        } else if(registerResModel.errors!.isNotEmpty){
          emit(RegisterInitialState());
          Fluttertoast.showToast(msg: "Credential invalid!");
        }

      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        emit(RegisterInitialState());
        emit(RegisterErrorState(errorMsg: e.toString()));
      }
    });
  }

}