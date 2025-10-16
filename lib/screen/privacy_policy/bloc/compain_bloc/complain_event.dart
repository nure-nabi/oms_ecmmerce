import 'package:equatable/equatable.dart';

abstract class ComplainEvent extends Equatable {}

class ComplainReqEvent extends ComplainEvent {
  String name;
  String email;
  String city;
  String phone;
  String remark;
  String? imagePath;

  ComplainReqEvent(
      {required this.name,
        required this.email,
        required this.city,
        required this.phone,
        required this.remark,
         this.imagePath}
      );

  @override
  List<Object?> get props => [name,email,city,phone,remark,imagePath];
}