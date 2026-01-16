

class PromotionRes {
 List<BannerImageModel> banners;
 PromotionRes({required this.banners});

 factory PromotionRes.fromJson(Map<String, dynamic> json){
   return PromotionRes(
     banners: json["promotions"] != null
         ? List<BannerImageModel>.from(
         json["promotions"].map((x) => BannerImageModel.fromJson(x)))
         : [],
   );
 }


}

class BannerImageModel{
  String? productCode;
  String? imageFullUrl;
  String? mobile_file_path;
  String? mobile_image_full_url;
  BannerProductModel? products;

  BannerImageModel({required this.productCode,required this.imageFullUrl,required this.products,
    this.mobile_file_path,this.mobile_image_full_url});

  factory BannerImageModel.fromJson(Map<String,dynamic> json){

    return BannerImageModel(
        productCode: json["product_code"] ?? "",
        imageFullUrl: json["image_full_url"] ?? "",
         mobile_file_path: json["mobile_file_path"] ?? "",
      mobile_image_full_url: json["mobile_image_full_url"] ?? "",
        products: json["product"] != null ? BannerProductModel.fromJson(json["product"]) : null,
    );

  }
}

class BannerProductModel{
  String? product_code;
  String? product_name;
  String? image_full_url;
  String? product_description;
  int? category_id;
  String? delivery_target_days;
  String? discount;
  String? actual_price;
  String? sell_price;
  String? mr_price;
  int? available_quantity;
  int? stock_quantity;
  int? has_variations;
  int? status;

  BannerProductModel({
    required this.product_code,
    required this.product_name,
    required this.image_full_url,
    required this.product_description,
    required this.category_id,
    required this.delivery_target_days,
    required this.discount,
    required this.actual_price,
    required this.sell_price,
    required this.mr_price,
    required this.available_quantity,
    required this.stock_quantity,
    required this.has_variations,
    required this.status,});


  factory BannerProductModel.fromJson(Map<String, dynamic> json){
    return BannerProductModel(
      product_code: json["product_code"] ?? "",
      product_name: json["product_name"] ?? "",
      image_full_url: json["image_full_url"] ?? "",
      product_description: json["product_description"] ?? "",
      category_id: json["category_id"] ?? 0,
      delivery_target_days:json["delivery_target_days"] ?? "",
      discount: json["discount"] ?? "",
      actual_price:json["actual_price"] ?? "",
      sell_price: json["sell_price"] ?? "",
      mr_price:json["mr_price"] ?? "",
      available_quantity: json["available_quantity"] ?? 0,
      stock_quantity: json["stock_quantity"] ?? 0,
      has_variations: json["has_variations"] ?? 0,
      status: json["status"] ?? "",);
  }

}

