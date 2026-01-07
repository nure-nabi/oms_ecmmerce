import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/screen/login/api/login_repo.dart';
import 'package:oms_ecommerce/screen/login/block/login_event.dart';
import 'package:oms_ecommerce/screen/login/block/login_state.dart';
import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/service/sharepref/set_all_pref.dart';

class LoginBlock extends Bloc<LoginEvent, LoginState> {
  LoginBlock() : super(LoginInitialState()) {
    on<LoginReqEvent>((event, emit) async {
      emit(LoginLoadingState());
      try{
        LoginRespModel loginRespModel = await LoginAPI.login(
            email: event.loginReqModel?.email ?? "",
            password: event.loginReqModel?.password ?? "");
        if(loginRespModel.success == true){
          LoadingOverlay.hide();
          await SetAllPref.loginSuccess(value: true);
          await SetAllPref.userId(value: loginRespModel.user!.id.toString());
          await SetAllPref.token(value: loginRespModel.token!.toString());
          emit(LoginLoadedState(loginRespModel: loginRespModel));
        }else{
          LoadingOverlay.hide();
          emit(LoginInitialState());
          Fluttertoast.showToast(msg: "Please enter valid user/password");
        }

      }catch(e){
        LoadingOverlay.hide();
        emit(LoginErrorState(errorMsg: e.toString()));
      }

    });

    on<LoginResetReqEvent>((event, emit) {
      emit(LoginInitialState());
    });
  }
}
