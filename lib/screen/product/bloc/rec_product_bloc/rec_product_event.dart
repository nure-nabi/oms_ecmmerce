import 'package:equatable/equatable.dart';

abstract class RecProductEvent extends Equatable{}

class RecProductReqEvent extends RecProductEvent{
  @override
  List<Object?> get props => [];
}