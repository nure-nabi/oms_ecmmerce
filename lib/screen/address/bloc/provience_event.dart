import 'package:equatable/equatable.dart';

abstract class ProvienceEvent extends Equatable{

}

class ProvienceReqEvent extends ProvienceEvent{
  String? province;
  String? city;
  String? zone;
  int? indexProvience;
  int? indexCity;
  int? indexZone;
  ProvienceReqEvent({this.province,this.city,this.zone,this.indexProvience,this.indexCity,this.indexZone});
  @override
  List<Object?> get props => [province,city,zone,indexProvience,indexCity,indexZone];
}

class ProvienceProvienceIndexEvent extends ProvienceEvent{
  int? index;
  String? province;
  String? city;
  String? zone;
  ProvienceProvienceIndexEvent({this.index,this.province,this.city,this.zone});
  @override
  List<Object?> get props => [index,province,city,zone];
}

class ProvienceZoneIndexEvent extends ProvienceEvent{
  int?indexProvience;
  int?indexcITY;
  int? indexZone;
  String? zoneValue;
  String? province;
  String? city;
  String? zone;
  ProvienceZoneIndexEvent({this.indexProvience, this.indexZone, this.indexcITY,this.zoneValue,this.province,this.city,this.zone});
  @override
  List<Object?> get props => [indexProvience,indexZone,indexcITY,zoneValue,province,city,zone];
}

class ProvienceSelectedIndexEvent extends ProvienceEvent{

  String? selectedCity;

  ProvienceSelectedIndexEvent({this.selectedCity});
  @override
  List<Object?> get props => [selectedCity];
}