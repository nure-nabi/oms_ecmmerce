class RecommendedProductResModel{
  bool success;
  String message;
  List<RecommendedProductModel> products;
  RecommendedProductResModel({required this.success,required this.message,required this.products,});

  factory RecommendedProductResModel.fromJson(Map<String,dynamic> json){
    return RecommendedProductResModel(
      products: json["recommended_products"] != null
          ? List<RecommendedProductModel>.from(
          json["recommended_products"].map((x) => RecommendedProductModel.fromJson(x)))
          : [], success: json["success"] ?? false, message: json["message"] ?? "",
    );
  }
}


class RecommendedProductModel{
  String? product_code;
  String? product_name;
  String? image_full_url;
  String? product_description;
  int? category_id;
 // String? delivery_target_days;
  String? discount;
  String? actual_price;
  String? sell_price;
  int? has_variations;
  String? mr_price;
  String? available_quantity;
  String? stock_quantity;
  int? status;

  RecommendedProductModel({
    required this.product_code,
    required this.product_name,
    required this.image_full_url,
    required this.product_description,
    required this.category_id,
   // required this.delivery_target_days,
    required this.discount,
    required this.actual_price,
    required this.sell_price,
    required this.has_variations,
    required this.mr_price,
    required this.available_quantity,
    required this.stock_quantity,
    required this.status,});


  factory RecommendedProductModel.fromJson(Map<String, dynamic> json){
   return RecommendedProductModel(
     product_code: json["product_code"] ?? "",
     product_name: json["product_name"] ?? "",
     image_full_url: json["image_full_url"] ?? "",
     product_description: json["product_description"] ?? "",
     category_id: json["category_id"] ?? 0,
    // delivery_target_days:json["delivery_target_days"] ?? "",
     discount: json["discount"] ?? "",
     actual_price:json["actual_price"] ?? "",
     sell_price: json["sell_price"] ?? "",
     has_variations: json["has_variations"] ?? 0,
     mr_price:json["mr_price"] ?? "",
     available_quantity: json["available_quantity"] ?? "",
     stock_quantity: json["stock_quantity"] ?? "",
     status: json["status"] ?? "",);
  }

}