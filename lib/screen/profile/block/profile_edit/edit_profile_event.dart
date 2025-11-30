import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable{}

class EditProfileReqEvent extends EditProfileEvent{
  String? userName;
  String? phone;
  String? image;
  EditProfileReqEvent({required this.userName,required this.phone,this.image});
  @override
  List<Object?> get props => [userName,phone,image];
}
class EditProfileClearReqEvent extends EditProfileEvent{
  @override
  List<Object?> get props => [];
}