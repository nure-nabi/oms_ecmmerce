import 'package:equatable/equatable.dart';

abstract class OfferEvent extends Equatable{}

class OfferReqEvent extends OfferEvent{
  @override
  List<Object?> get props => [];
}