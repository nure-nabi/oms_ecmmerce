import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';
import 'package:oms_ecommerce/screen/forget_password/api/forget_password_repo.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_event.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_state.dart';
import 'package:oms_ecommerce/screen/forget_password/model/forget_password_model.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitialState()) {
    on<ChangePasswordReqEvent>(_onForgetPasswordReqEvent);
  }

  Future<void> _onForgetPasswordReqEvent(
    ChangePasswordReqEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoadingState());
    try {
      BasicModel resp = await ForgetPasswordRepo.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
        newConfirm: event.newConfirmPassword,
      );

      if (resp.success == true) {
        emit(ChangePasswordLoadedState(basicModel: resp));
      } else {
        emit(ChangePasswordErrorState(errorMsg:"Something wrong!"));
        emit(ChangePasswordInitialState());
      }
    } catch (e) {
      emit(ChangePasswordErrorState(errorMsg: e.toString()));
    }
  }
}
