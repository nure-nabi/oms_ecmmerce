import 'package:oms_ecommerce/screen/address/model/address_model.dart';
import 'package:oms_ecommerce/screen/address/model/provience_model.dart';
import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';

class UserInfoResMode {
  bool? success;
  String? message;
  UserModel? user;
  List<AddressProfileModel>? addresses;
  UserInfoResMode(
      {required this.success, required this.message, required this.user,this.addresses});

  factory UserInfoResMode.fromJson(Map<String, dynamic> json){
    return UserInfoResMode(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      user: json["data"] != null ? UserModel.fromJson(json["data"]) : null,
      addresses: json["addresses"] != null
          ? List<AddressProfileModel>.from(
          json["addresses"].map((x) => AddressProfileModel.fromJson(x)))
          : [],
      //   user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }


}


class UserModel {
  String? full_name;
  String? phone;
  String? email;
  String? image_full_url;


  UserModel(
      {required this.full_name, required this.phone, required this.email, required this.image_full_url});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      full_name: json["full_name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      image_full_url: json["image_full_url"] ?? "",

    );
  }
}

class AddressProfileModel {
  int? id;
  int? customer_id;
  String? full_name;
  int? province_id;
  int? city_id;
  int? zone_id;
  String? phone;
  String? address;
  String? landmark;
  String? address_type;
  String? default_shipping;
  String? default_billing;
  ProviencepProfileModel? provience;
  CityProfileModel? city;
  ZoneProfileModel? zone;

  AddressProfileModel({
    required this.id,
    required this.customer_id,
    required this.full_name,
    required this.province_id,
    required this.city_id,
    required this.zone_id,
    required this.phone,
    required this.address,
    required this.landmark,
    required this.address_type,
    required this.default_shipping,
    required this.default_billing,
     this.provience,
     this.city,
     this.zone,

  });

  factory AddressProfileModel.fromJson(Map<String, dynamic> json){
    return AddressProfileModel(
        id: json["id"] ?? 0,
        customer_id: json["customer_id"] ?? 0,
        full_name: json["full_name"] ?? "",
        province_id: json["province_id"] ?? 0,
        city_id: json["city_id"] ?? 0,
        zone_id: json["zone_id"] ?? 0,
        phone: json["phone"] ?? "",
        address: json["address"] ?? "",
        landmark: json["landmark"] ?? "",
        address_type: json["address_type"] ?? "",
        default_shipping: json["default_shipping"] ?? "",
        default_billing: json["default_billing"] ?? "",
        provience: json["province"] != null ? ProviencepProfileModel.fromJson(json["province"]) : null,
        city: json["city"] != null ? CityProfileModel.fromJson(json["city"]) : null,
        zone: json["zone"] != null ? ZoneProfileModel.fromJson(json["zone"]) : null,
    );

  }
}

class ProviencepProfileModel{
  int? id;
  String? province_name;
  ProviencepProfileModel({required this.id,required this.province_name});
  factory ProviencepProfileModel.fromJson(Map<String, dynamic> json){
    return ProviencepProfileModel(
        id: json["id"] ?? 0,
        province_name: json["province_name"] ?? ""
    );
  }
}

class CityProfileModel{
  int? id;
  int? province_id;
  String? city;
  String? shipping_cost;
  CityProfileModel({required this.id,required this.province_id,required this.city,required this.shipping_cost});
  factory CityProfileModel.fromJson(Map<String, dynamic> json){
    return CityProfileModel(
        id: json["id"] ?? 0,
        province_id: json["province_id"] ?? 0,
        city: json["city"] ?? "",
      shipping_cost: json["shipping_cost"] ?? "",
    );
  }
}

class ZoneProfileModel{
  int? id;
  int? city_id;
  String? zone_name;
  ZoneProfileModel({required this.id,required this.city_id,required this.zone_name});
  factory ZoneProfileModel.fromJson(Map<String, dynamic> json){
    return ZoneProfileModel(
        id: json["id"] ?? 0,
        city_id: json["city_id"] ?? 0,
        zone_name: json["zone_name"] ?? ""
    );
  }
}