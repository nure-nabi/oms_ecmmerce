class SearchProductResp {
   bool success;
   String message;
   ProductModel? product;

  SearchProductResp({
    required this.success,
    required this.message,
    required this.product,
  });


  factory SearchProductResp.fromJson(Map<String, dynamic> json) {
    return SearchProductResp(
      success: json["success"] ?? 0,
      message: json["message"] ?? "",
      product: json["products"] != null ? ProductModel.fromJson(json["products"]) : null,


    );
  }


}

class ProductModel{
  int total_size;
  List<SearchProductsModel> data;
  ProductModel({required this.total_size,required this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
        total_size: json['total_size'] ?? 0,
      data: json["products"] != null
    ? List<SearchProductsModel>.from(
    json["products"].map((x) => SearchProductsModel.fromJson(x)))
    : [],
    );
  }
}

class SearchProductsModel{
  String? product_code;
  String? product_name;
  String? image_full_url;
  String? main_image_full_url;
  String? product_description;
  int? category_id;
  String? delivery_target_days;
  String? discount;
  String? actual_price;
  String? sell_price;
  int? available_quantity;
  int? stock_quantity;
  int? status;
  int? has_variations;
  String? key_specifications;
  String? packaging;
  String? warranty;
  bool? is_wishlisted;
  String? catalogue_full_url;
  String? average_rating;
  int? review_count;

  SearchProductsModel({
    required this.product_code,
    required this.product_name,
    required this.image_full_url,
    required this.main_image_full_url,
    required this.product_description,
    required this.category_id,
    required this.delivery_target_days,
    required this.discount,
    required this.actual_price,
    required this.sell_price,

    required this.available_quantity,
    required this.stock_quantity,
    required this.status,
    required this.has_variations,
    required this.key_specifications,
    required this.packaging,
    required this.warranty,
    required this.is_wishlisted,
    required this.catalogue_full_url,
    required this.average_rating,
    required this.review_count,

  });

  factory SearchProductsModel.fromJson(Map<String, dynamic> json){
    return SearchProductsModel(
        product_code: json["product_code"] ?? "",
        product_name: json["product_name"] ?? "",
        image_full_url: json["image_full_url"] ?? "",
        main_image_full_url: json["main_image_full_url"] ?? "",
        product_description: json["product_description"] ?? "",
        category_id: json["category_id"] ?? 0,
        delivery_target_days:json["delivery_target_days"] ?? "0",
        discount: json["discount"] ?? "0",
        actual_price:json["actual_price"] ?? "",
        sell_price: json["sell_price"] ?? "",

        available_quantity: json["available_quantity"] ?? 0,
        stock_quantity: json["stock_quantity"] ?? 0,
        status: json["status"] ?? 0,
        has_variations: json["has_variations"] ?? 0,
        key_specifications: json["key_specifications"] ?? "",
        packaging: json["packaging"] ?? "",
        warranty: json["warranty"] ?? "",
        is_wishlisted: json["is_wishlisted"] ?? false,
        catalogue_full_url: json["catalogue_full_url"] ?? "",
        average_rating: json["average_rating"] ?? "",
        review_count: json["review_count"] ?? "",
    );
  }


}