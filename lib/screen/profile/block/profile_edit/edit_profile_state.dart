import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/profile/model/user_model.dart';

abstract class EditProfileState extends Equatable{}

class EditProfileInitialState extends EditProfileState{
  @override
  List<Object?> get props => [];
}
class EditProfileLoadingState extends EditProfileState{
  @override
  List<Object?> get props => [];
}
class EditProfileLoadedState extends EditProfileState{
  UserInfoResMode? userInfoResMode;
  EditProfileLoadedState({required this.userInfoResMode});
  EditProfileLoadedState copyWith({UserInfoResMode? userInfoResMode}){
    return EditProfileLoadedState(
        userInfoResMode: userInfoResMode ?? this.userInfoResMode);
  }
  @override
  List<Object?> get props => [];
}
class EditProfileErrorState extends EditProfileState{
  String? errorMsg;
  EditProfileErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}