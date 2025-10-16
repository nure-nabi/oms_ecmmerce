// https://garg.omsok.com/api/v1/customer/address/load-address-dropdowns
// https://garg.omsok.com/api/v1/customer/address/add
// https://garg.omsok.com/api/v1/customer/address/update/{id}
// https://garg.omsok.com/api/v1/customer/address/set-default-shipping/{id}
// https://garg.omsok.com/api/v1/customer/address/set-default-billing/{id}
// https://garg.omsok.com/api/v1/customer/address/remove/{id}

import 'dart:convert';

import 'package:oms_ecommerce/screen/address/model/address_model.dart';

import '../../../utils/custom_log.dart';
import '../../service/apiprovider.dart';
import '../model/provience_model.dart';

class AddressRepo{
  static Future getProvience() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/customer/address/load-address-dropdowns",
    );
    CustomLog.successLog(value: "RESPONSE Address => $jsonData");
    return ProvienceResModel.fromJson(jsonData);
  }

  static Future getAddress() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/customer/address/list",
    );
    CustomLog.successLog(value: "RESPONSE Address => $jsonData");
    return AddressResponseModel.fromJson(jsonData);
  }

  static Future saveAddress({
    required String full_name,
    required String phone,
    required String province,
    required String city,
    required String zone,
    required String address,
    required String address_type,
    required String default_shipping,
    required String default_billing,
    required String landmark,
  }) async {
    AddressModel addReqAddress = AddressModel(
        full_name: full_name,
        phone: phone,
        province: province,
        city: city,
        zone: zone,
        address: address,
        address_type: address_type,
        default_shipping: default_shipping,
        default_billing: default_billing,
        landmark: landmark,
    );
    var body = jsonEncode(addReqAddress.toJson());

    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/customer/address/add",
      body: body,
    );

    CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return AddressResponse.fromJson(jsonData);
  }

  static Future updateAddress({
    required String id,
    required String full_name,
    required String phone,
    required String province,
    required String city,
    required String zone,
    required String address,
    required String address_type,
    required String default_shipping,
    required String default_billing,
    required String landmark,
  }) async {
    AddressModel addReqAddress = AddressModel(
      id: id,
      full_name: full_name,
      phone: phone,
      province: province,
      city: city,
      zone: zone,
      address: address,
      address_type: address_type,
      default_shipping: default_shipping,
      default_billing: default_billing,
      landmark: landmark,
    );
    var body = jsonEncode(addReqAddress.toJson());

    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/customer/address/update/${id}",
      body: body,
    );

    CustomLog.successLog(value: "RESPONSE Update Data => $jsonData");
    return AddressResponse.fromJson(jsonData);
  }

  static Future updateBilling({
    required String id,
  }) async {
    AddressModel addReqAddress = AddressModel(
      id: id,
    );

    var jsonData = await APIProvider.postSingleAPI(
      endPoint: "v1/customer/address/set-default-billing/${id}",
      method: 'POST',
    );
    CustomLog.successLog(value: "RESPONSE Update Billing => $jsonData");
    return AddressResponse.fromJson(jsonData);
  }
  static Future updateShipping({
    required String id,
  }) async {
    AddressModel addReqAddress = AddressModel(
      id: id,
    );

    var jsonData = await APIProvider.postSingleAPI(
      endPoint: "v1/customer/address/set-default-shipping/${id}",
      method: 'POST',
    );
    CustomLog.successLog(value: "RESPONSE Update shipping => $jsonData");
    return AddressResponse.fromJson(jsonData);
  }

  static Future deleteAddress({
    required String id,
  }) async {

    var jsonData = await APIProvider.postSingleAPI(
      endPoint: "v1/customer/address/remove/${id}",
      method: 'Delete',
    );
    CustomLog.successLog(value: "RESPONSE Update delete address => $jsonData");
    return AddressResponse.fromJson(jsonData);
  }

  //// https://garg.omsok.com/api/v1/customer/address/remove/{id}
}