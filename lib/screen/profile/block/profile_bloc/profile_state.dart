import 'package:equatable/equatable.dart';

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
  UserInfoResMode? userInfoResMode;
  ProfileLoadedState({required this.userInfoResMode});

  ProfileLoadedState copyWith(UserInfoResMode? userInfoResMode){
    return ProfileLoadedState(
        userInfoResMode: userInfoResMode ?? this.userInfoResMode);
  }
  @override
  List<Object?> get props => [];
}
class ProfileErrorState extends ProfileState{
  String? errorMsg;
  UserInfoResMode? userInfoResMode;
  ProfileErrorState({ this.errorMsg, this.userInfoResMode});
  @override
  List<Object?> get props => [errorMsg,userInfoResMode];
}