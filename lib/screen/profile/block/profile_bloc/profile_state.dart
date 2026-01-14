import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';

import '../../model/user_model.dart';

abstract class ProfileState extends Equatable{}

class ProfileInitialState extends ProfileState{
  @override
  List<Object?> get props => [];
}
class ProfileLoadingState extends ProfileState{
  @override
  List<Object?> get props => [];
}
class ProfileLoadedState extends ProfileState{
 final UserInfoResMode? userInfoResMode;
 final BasicModel? basicModel;
  ProfileLoadedState({ this.userInfoResMode,this.basicModel});

  ProfileLoadedState copyWith(UserInfoResMode? userInfoResMode){
    return ProfileLoadedState(
        userInfoResMode: userInfoResMode ?? this.userInfoResMode);
  }
  @override
  List<Object?> get props => [userInfoResMode,basicModel];
}
class ProfileErrorState extends ProfileState{
  String? errorMsg;
  UserInfoResMode? userInfoResMode;
  ProfileErrorState({ this.errorMsg, this.userInfoResMode});
  @override
  List<Object?> get props => [errorMsg,userInfoResMode];
}