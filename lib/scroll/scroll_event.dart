import 'package:equatable/equatable.dart';

abstract class ScrollEvent extends Equatable{}

class ScrollReqEvent extends ScrollEvent{
  bool scrollFlag;
  ScrollReqEvent({required this.scrollFlag});
  @override
  List<Object?> get props => [];
}