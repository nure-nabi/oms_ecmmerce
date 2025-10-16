import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/profile/api/user_repo.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_event.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_state.dart';
import 'package:oms_ecommerce/screen/profile/model/user_model.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  UserInfoResMode? userInfoResMode;
  ProfileBloc(): super(ProfileInitialState()){
    on<ProfileReqEvent>((event,emit)async{
      emit(ProfileLoadingState());
      userInfoResMode = await UserRepo.getProfile();
      if(userInfoResMode == null) {
       // Fluttertoast.showToast(msg: "One");
        try {
          if (userInfoResMode!.success == true) {
            emit(ProfileLoadedState(userInfoResMode: userInfoResMode));
          }else{
            emit(ProfileErrorState(errorMsg: "",));
          }
        } catch (e) {
         // emit(ProfileErrorState(errorMsg: e.toString(),userInfoResMode: userInfoResMode));
        }
      }else{
        if(userInfoResMode != null){
          try{
            if(userInfoResMode!.success == false){
              emit(ProfileErrorState(errorMsg: "",));
            }else{
              emit(ProfileLoadedState(userInfoResMode: userInfoResMode));
            }
          }catch(e){
            emit(ProfileErrorState(errorMsg: e.toString(),userInfoResMode: userInfoResMode));
          }


        }else{
        //  emit(ProfileErrorState(errorMsg: "",userInfoResMode: userInfoResMode));
        }

      }
    });

    on<ProfileClearDataEvent>((event,emit){
      userInfoResMode = null;
    });
  }
}