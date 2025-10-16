import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/address/api/addrees_repo.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_event.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_state.dart';
import 'package:oms_ecommerce/screen/cart/bloc/add_cart/add_cart_state.dart';

import '../../../component/loading_overlay.dart';
import '../../../utils/custome_toast.dart';
import '../model/address_model.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressResponseModel? responseModel;
  AddressBloc() : super(AddressInitialState()) {

    on<AddressReqEvent>((event, omit) async{
    //  omit(AddressLoadingState());
     responseModel = await  AddressRepo.getAddress();

      omit(AddressLoadedState(
          addressTypeHomeFlag: event.typeHomeFlag,
          addressTypeOfficeFlag: event.typeOfficeFlag,
          shippingFlag: event.shippingFlag,
          billingFlag: event.billingFlag,
         addressResponseModel: responseModel
      ));

    });

    on<AddressSaveEvent>((event, omit) async{
   late   AddressResponse response;
      if(event.valueMap == "Update"){
        response =  await AddressRepo.updateAddress(
            full_name: event.addressModel!.full_name!,
            phone: event.addressModel!.phone!,
            province: event.addressModel!.province!,
            city: event.addressModel!.city!,
            zone: event.addressModel!.zone!,
            address: event.addressModel!.address!,
            address_type: event.addressModel!.address_type!,
            default_shipping: "",
            default_billing: "",
            landmark: event.addressModel!.landmark!,
            id: event.addressModel!.id!);
        if(response.success == true){
          responseModel = await  AddressRepo.getAddress() ;
          omit(AddressLoadedState(addressResponseModel: responseModel));
          CustomToast.showCustomRoast(context: event.context, message: response.message!, icon: Bootstrap.check_circle);
          Navigator.pushReplacementNamed(event.context, addressShow);
          LoadingOverlay.hide();
        }
      }else{
         response =  await AddressRepo.saveAddress(
            full_name: event.addressModel!.full_name!,
            phone: event.addressModel!.phone!,
            province: event.addressModel!.province!,
            city: event.addressModel!.city!,
            zone: event.addressModel!.zone!,
            address: event.addressModel!.address!,
            address_type: event.addressModel!.address_type!,
            default_shipping: event.addressModel!.default_shipping!,
            default_billing: event.addressModel!.default_billing!,
            landmark: event.addressModel!.landmark!);
        if(response.success == true){
          responseModel = await  AddressRepo.getAddress() ;
          omit(AddressLoadedState(addressResponseModel: responseModel));
          LoadingOverlay.hide();
          CustomToast.showCustomRoast(context: event.context, message: response.message!, icon: Bootstrap.check_circle);
          Navigator.pushReplacementNamed(event.context, addressShow);
        }
      }
     // omit(AddressLoadedState(addressResponse: response));
    });

    on<AddressShippingEvent>((event, omit) {
      omit((state as AddressLoadedState).copyWith(shippingFlag: event.shippingFlag));
     // omit(AddressLoadedState(shippingFlag: event.shippingFlag));
    });
    on<AddressBillingEvent>((event, omit) {
      omit((state as AddressLoadedState).copyWith(shippingFlag: event.billingFlag));
     // omit(AddressLoadedState(billingFlag: event.billingFlag));
    });

    on<AddressBillingBillingEvent>((event,omit)async{
      AddressResponse response =  await AddressRepo.updateBilling(id: event.id!);
      if(response.success == true){
        responseModel = await  AddressRepo.getAddress() ;
        omit(AddressLoadedState(addressResponseModel: responseModel));
        LoadingOverlay.hide();
      }
     // UserInfoResMode userInfoResMode = await UserRepo.getProfile();
    });

    on<AddressBillingShippingEvent>((event,omit)async{
      AddressResponse response =  await AddressRepo.updateShipping(id: event.id!);
      if(response.success == true){
        responseModel = await  AddressRepo.getAddress() ;
        omit(AddressLoadedState(addressResponseModel: responseModel));
        LoadingOverlay.hide();
      }
      // UserInfoResMode userInfoResMode = await UserRepo.getProfile();
    });

    on<AddressDeleteEvent>((event,omit)async{
      AddressResponse response =  await AddressRepo.deleteAddress(id: event.id!);
      if(response.success == true){
        responseModel = await  AddressRepo.getAddress() ;
        omit(AddressLoadedState(addressResponseModel: responseModel));
        LoadingOverlay.hide();
      }
      // UserInfoResMode userInfoResMode = await UserRepo.getProfile();
    });

    on<AddressClearEvent>((event,emit){
      responseModel = null;
    });
  }
}