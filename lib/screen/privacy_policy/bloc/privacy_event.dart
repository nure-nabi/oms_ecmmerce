import 'package:equatable/equatable.dart';

abstract class PrivacyEvent extends Equatable{}

class PrivacyReqEvent extends PrivacyEvent{
  String? title;
  PrivacyReqEvent({ this.title});
  @override
  List<Object?> get props => [title];
}