class OfferResp{
  bool? success;
  String? message;
  List<OfferModel> data;
  OfferResp({required this.success,required this.message,required this.data});

  factory OfferResp.fromJson(Map<String,dynamic> json){
    return OfferResp(
      success: json["success"] ?? false,
      message:json["message"] ?? "",
        data : json["offers"] != null
            ? List<OfferModel>.from(
            json["offers"].map((x) => OfferModel.fromJson(x)))
            : [],
    );
  }
}

class OfferModel{
  int? is_active;
  String? offer_image_full_url;

  OfferModel({required this.is_active,
    required this.offer_image_full_url,

  });

  factory OfferModel.fromJson(Map<String,dynamic> json){
    return OfferModel(
      is_active: json["is_active"] ?? 1,
      offer_image_full_url: json["offer_image_full_url"] ?? "",

    );
  }
}