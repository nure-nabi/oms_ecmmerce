import 'package:equatable/equatable.dart';

import '../model/offer_model.dart';


abstract class OfferState extends Equatable{}

class OfferInitialState extends OfferState{
  @override
  List<Object?> get props => [];
}

class OfferLoadingState extends OfferState{
  @override
  List<Object?> get props => [];
}

class OfferLoadedState extends OfferState{
  final OfferResp offerResp;
  OfferLoadedState({required this.offerResp});
  @override
  List<Object?> get props => [offerResp];
}

class OfferErrorState extends OfferState{
  String errorMsg;
  OfferErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}