import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';
import 'package:oms_ecommerce/screen/forget_password/api/forget_password_repo.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_event.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_state.dart';
import 'package:oms_ecommerce/screen/forget_password/model/forget_password_model.dart';

import '../api/reset_password_repo.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitialState()) {
    on<ResetPasswordReqEvent>(_onResetPasswordReqEvent);
  }

  Future<void> _onResetPasswordReqEvent(
    ResetPasswordReqEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoadingState());
    try {
      BasicModel resp = await ResetPasswordRepo.resetPassword(
        email: event.email,
        reset_code:event.reset_code,
        new_password: event.new_password,
        confirm_new_password: event.confirm_new_password,
      );

      if (resp.success == true) {
        emit(ResetPasswordLoadedState(basicModel: resp));
      } else {
        emit(ResetPasswordInitialState());
      }
    } catch (e) {
      emit(ResetPasswordErrorState(errorMsg: e.toString()));
    }
  }
}
