import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/screen/forget_password/api/forget_password_repo.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_event.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_state.dart';
import 'package:oms_ecommerce/screen/forget_password/model/forget_password_model.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent,ForgetPasswordState>{
  ForgetPasswordBloc() : super(ForgetPasswordInitialState()){
    on<ForgetPasswordReqEvent>(_onForgetPasswordReqEvent);

  }
  Future<void> _onForgetPasswordReqEvent(
      ForgetPasswordReqEvent event,
      Emitter<ForgetPasswordState> emit
      )async {
      emit(ForgetPasswordLoadingState());
      try{
        ForgetPasswordResp resp = await ForgetPasswordRepo.forgetPassword(email: event.email);

        if(resp.success == true){
        emit(ForgetPasswordLoadedState(forgetPasswordResp: resp));
        }else{
          emit(ForgetPasswordErrorState(errorMsg:"Something wrong!"));
        }
      }catch(e){
        emit(ForgetPasswordErrorState(errorMsg:e.toString()));
      }
     }
}