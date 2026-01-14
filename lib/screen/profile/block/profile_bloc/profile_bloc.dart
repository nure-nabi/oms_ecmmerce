import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/profile/api/user_repo.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_event.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_state.dart';
import 'package:oms_ecommerce/screen/profile/model/user_model.dart';

import '../../../../basic_model/basic_model.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  UserInfoResMode? userInfoResMode;
  ProfileBloc(): super(ProfileInitialState()){
    on<ProfileReqEvent>((event,emit)async{
      //emit(ProfileLoadingState());
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

    on<AccountRemovedEvent>((event,emit) async {
      BasicModel basicModel = await UserRepo.removedAccount();
      try{
        if(basicModel.success == true){
          Fluttertoast.showToast(msg: basicModel.message!);
          Navigator.pop(event.context);
          emit(ProfileLoadedState(basicModel: basicModel));
       }else{
          Navigator.pop(event.context);
          Fluttertoast.showToast(msg: basicModel.errors![0].message.toString());
        }
      }catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }
    });
  }
}