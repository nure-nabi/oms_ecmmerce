import 'package:equatable/equatable.dart';

import '../model/provience_model.dart';

abstract class ProvienceState extends Equatable{

}

class ProvienceInitialState extends ProvienceState{
  @override
  List<Object?> get props => [];
}

class ProvienceLoadingState extends ProvienceState{
  @override
  List<Object?> get props => [];
}

class ProvienceLoadedState extends ProvienceState{
  ProvienceResModel? provienceRes;
  int? indexProvience;
  int? indexCity;
  int? indexZone;
  String? zoveValue;
  String? provienceValue;
 late String? cityValue;
  String? zoneValues;
  ProvienceLoadedState({
    this.indexProvience,
    this.provienceRes,
    this.indexCity,
    this.indexZone,
    this.zoveValue,
    this.provienceValue,
    this.cityValue,
    this.zoneValues,
  });
  @override
  List<Object?> get props => [indexProvience,provienceRes,indexCity,indexZone,zoveValue,provienceValue,cityValue,zoneValues];
}

class ProvienceErrorState extends ProvienceState{
  String? errorMsg;
  ProvienceErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}