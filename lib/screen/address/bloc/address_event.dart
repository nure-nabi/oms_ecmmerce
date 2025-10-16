import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oms_ecommerce/screen/address/model/address_model.dart';

 abstract class AddressEvent extends Equatable{
}

class AddressReqEvent extends AddressEvent{
   bool? typeHomeFlag;
   bool? typeOfficeFlag;
   bool? shippingFlag;
   bool? billingFlag;

   AddressReqEvent({ this.typeHomeFlag, this.typeOfficeFlag,this.shippingFlag=false,this.billingFlag=false});
  @override
  List<Object?> get props => [typeHomeFlag,typeOfficeFlag,shippingFlag,billingFlag];

}

class AddressShippingEvent extends AddressEvent{
   bool shippingFlag = false;
   AddressShippingEvent({required this.shippingFlag});
  @override
  List<Object?> get props => [shippingFlag];
}

class AddressBillingEvent extends AddressEvent{
  bool billingFlag = false;
  AddressBillingEvent({required this.billingFlag});
  @override
  List<Object?> get props => [billingFlag];
}

class AddressSaveEvent extends AddressEvent{
   String? valueMap;
   AddressModel? addressModel;
   BuildContext context;
   AddressSaveEvent({this.addressModel,this.valueMap,required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [addressModel,valueMap,context];
}

class AddressBillingBillingEvent extends AddressEvent{
  String? id;
  AddressBillingBillingEvent({this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id,];
}

class AddressBillingShippingEvent extends AddressEvent{
  String? id;
  AddressBillingShippingEvent({this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id,];
}
class AddressDeleteEvent extends AddressEvent{
  String? id;
  AddressDeleteEvent({this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id,];
}

class AddressClearEvent extends AddressEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}