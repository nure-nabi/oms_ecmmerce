import 'package:equatable/equatable.dart';

import '../model/address_model.dart';

abstract class AddressState extends Equatable{

}

class AddressInitialState extends AddressState{
  @override
  List<Object?> get props => [];
}

class AddressLoadingState extends AddressState{
  @override
  List<Object?> get props => [];
}

class AddressLoadedState extends AddressState{
  AddressResponse? addressResponse;
  bool? addressTypeHomeFlag;
  bool? addressTypeOfficeFlag;
  bool? shippingFlag;
  bool? billingFlag;
  AddressResponseModel? addressResponseModel;
  AddressLoadedState({this.addressTypeHomeFlag=false,this.addressTypeOfficeFlag=false,
    this.shippingFlag=false,this.billingFlag=false,this.addressResponse,this.addressResponseModel});

  AddressLoadedState copyWith({bool? shippingFlag,bool? billingFlag}){
     return AddressLoadedState(
       shippingFlag: shippingFlag ?? this.shippingFlag,
       billingFlag: billingFlag ?? this.billingFlag,
     );
  }
  @override
  List<Object?> get props => [addressTypeHomeFlag,addressTypeOfficeFlag,shippingFlag,billingFlag,addressResponse,addressResponseModel];
}

class AddressErrorState extends AddressState{
  String? errorMsg;
  AddressErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}