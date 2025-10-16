import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/screen/verification_register/api/verification_repo.dart';
import 'package:oms_ecommerce/screen/verification_register/model/verification_model.dart';
import 'package:oms_ecommerce/screen/verification_register/verification_bloc/verification_event.dart';
import 'package:oms_ecommerce/screen/verification_register/verification_bloc/verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent,VerificationState>{
  VerificationBloc() : super(VerificationInitialState()){
    on<VerificationReqEvent>((event,emit) async{
      emit(VerificationLoadingState());

    try{
      VerificationResModel verificationResModel = await  VerificationRepo.verification(
        code: event.verificationReqModel?.verificationCode ?? "",
        email: event.verificationReqModel?.email ?? "",
      );

      emit(VerificationLoadedState(verificationResModel: verificationResModel));
    }catch(e){
      emit(VerificationErrorState(errorMsg: e.toString()));
    }

    });

  }
}