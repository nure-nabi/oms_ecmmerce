import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ComplainEvent extends Equatable {}

class ComplainReqEvent extends ComplainEvent {
  String name;
  String email;
  String city;
  String phone;
  String remark;
  String? imagePath;
  BuildContext? context;

  ComplainReqEvent(
      {required this.name,
        required this.email,
        required this.city,
        required this.phone,
        required this.remark,
         this.imagePath,
         this.context,
      }
      );

  @override
  List<Object?> get props => [name,email,city,phone,remark,imagePath,context];
}