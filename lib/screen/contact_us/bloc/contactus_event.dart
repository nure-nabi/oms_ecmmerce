import 'package:equatable/equatable.dart';

abstract class ContactusEvent extends Equatable{}

class ContactReqEvent extends ContactusEvent{
  String name;
  String email;
  String message;
  ContactReqEvent({required this.name, required this.email, required this.message});
  @override
  List<Object?> get props => [name,email,message];
}