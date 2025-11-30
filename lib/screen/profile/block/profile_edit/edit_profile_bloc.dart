import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/screen/profile/api/user_repo.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_edit/edit_profile_event.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_edit/edit_profile_state.dart';
import 'package:oms_ecommerce/screen/profile/model/user_model.dart';

import '../../../../utils/custome_toast.dart';

class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileState>{
  EditProfileBloc() : super(EditProfileInitialState()){
    on<EditProfileReqEvent>((event, emit)async{
      emit(EditProfileLoadingState());
      try{
      UserInfoResMode userInfoResMode =   await UserRepo.updateProfile(
          full_name: event.userName!,
          phone: event.phone!,
          image: event.image!);
       if(userInfoResMode.success!){
        LoadingOverlay.hide();
        emit(EditProfileLoadedState(userInfoResMode: userInfoResMode));
       }

      }catch(e){
       // Fluttertoast.showToast(msg: e.toString());
        LoadingOverlay.hide();
        emit(EditProfileErrorState(errorMsg: e.toString()));
      }
    });

    on<EditProfileClearReqEvent>((event,emit){
      emit(EditProfileInitialState());
    });
  }

}