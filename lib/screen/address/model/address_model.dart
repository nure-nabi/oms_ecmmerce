


class AddressResponse{
  bool? success;
  String? message;
  String? order_id;

  AddressResponse({this.success,this.message,this.order_id});

  factory AddressResponse.fromJson(Map<String,dynamic> json){
    return AddressResponse(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
      order_id: json["order_id"] ?? "",
    );
}
}
class AddressModel{
  String? id;
  String? full_name;
  String? phone;
  String? province;
  String? city;
  String? zone;
  String? address;
  String? address_type;
  String? default_shipping;
  String? default_billing;
  String? landmark;

  AddressModel({
    this.id,
    this.full_name,
    this.phone,
    this.province,
    this.city,
    this.zone,
    this.address,
    this.address_type,
    this.default_shipping,
    this.default_billing,
    this.landmark,

});

  factory AddressModel.fromJson(Map<String, dynamic> json){
    return AddressModel(
    id: json["id"] ?? "",
    full_name: json["full_name"] ?? "",
    phone: json["phone"] ?? "",
    province: json["province"] ?? "",
    city: json["city"] ?? "",
    zone: json["zone"] ?? "",
    address: json["address"] ?? "",
    address_type: json["address_type"] ?? "",
    default_shipping: json["default_shipping"] ?? "",
    default_billing: json["default_billing"] ?? "",
    landmark: json["landmark"] ?? "",
    );
}

  Map<String, dynamic> toJson() => {
    "full_name": full_name,
    "phone": phone,
    "province": province,
    "city": city,
    "zone": zone,
    "address": address,
    "address_type": address_type,
    "default_shipping": default_shipping,
    "default_billing": default_billing,
    "landmark": landmark,
  };
}


class AddressResponseModel {
  bool? success;
  String? message;
  List<AddressShowModel>? addresses;
  AddressResponseModel(
      {required this.success, required this.message,this.addresses});

  factory AddressResponseModel.fromJson(Map<String, dynamic> json){
    return AddressResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      addresses: json["addresses"] != null
          ? List<AddressShowModel>.from(
          json["addresses"].map((x) => AddressShowModel.fromJson(x)))
          : [],
      //   user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }


}




class AddressShowModel {
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

  AddressShowModel({
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

  factory AddressShowModel.fromJson(Map<String, dynamic> json){
    return AddressShowModel(
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
  int? apply_shipping;
  CityProfileModel({required this.id,required this.province_id,required this.city,this.shipping_cost,this.apply_shipping});
  factory CityProfileModel.fromJson(Map<String, dynamic> json){
    return CityProfileModel(
        id: json["id"] ?? 0,
        province_id: json["province_id"] ?? 0,
        city: json["city"] ?? "",
        shipping_cost: json["shipping_cost"] ?? "",
        apply_shipping: json["apply_shipping"] ?? 0
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