class LatestProductResModel{
  List<LatestProductModel> products;
  LatestProductResModel({required this.products});

  factory LatestProductResModel.fromJson(Map<String,dynamic> json){
    return LatestProductResModel(
      products: json["products"] != null
          ? List<LatestProductModel>.from(
          json["products"].map((x) => LatestProductModel.fromJson(x)))
          : [],
    );
  }
}


class LatestProductModel{
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
  String? mr_price;
  int? available_quantity;
  int? stock_quantity;
  int? status;
  int? has_variations;
  int? flash_sale;
  String? key_specifications;
  String? packaging;
  String? warranty;
  String? starting_price;
  bool? is_wishlisted;
  String? average_rating;
  int? review_count;
  List<VariationsModel> variations;
  List<ReviewModel> reviews;

  LatestProductModel({
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
    required this.mr_price,
    required this.available_quantity,
    required this.stock_quantity,
    required this.flash_sale,
    required this.status,
    required this.has_variations,
    required this.key_specifications,
    required this.packaging,
    required this.warranty,
    required this.starting_price,
    required this.is_wishlisted,
    required this.average_rating,
    required this.review_count,
    required this.variations,
    required this.reviews,
  });


  factory LatestProductModel.fromJson(Map<String, dynamic> json){
   return LatestProductModel(
     product_code: json["product_code"] ?? "",
     product_name: json["product_name"] ?? "",
     image_full_url: json["image_full_url"] ?? "",
     main_image_full_url: json["main_image_full_url"] ?? "",
     product_description: json["product_description"] ?? "",
     category_id: json["category_id"] ?? 0,
     delivery_target_days:json["delivery_target_days"] ?? "",
     discount: json["discount"] ?? "",
     actual_price:json["actual_price"] ?? "",
     sell_price: json["sell_price"] ?? "",
     mr_price:json["mr_price"] ?? "",
     available_quantity: json["available_quantity"] ?? 0,
     stock_quantity: json["stock_quantity"] ?? 0,
       flash_sale: json["flash_sale"] ?? 0,
     status: json["status"] ?? 0,
     has_variations: json["has_variations"] ?? 0,
     key_specifications: json["key_specifications"] ?? "",
     packaging: json["packaging"] ?? "",
     warranty: json["warranty"] ?? "",
       starting_price: json["starting_price"] ?? "",
       is_wishlisted: json["is_wishlisted"] ?? false,
       average_rating: json["average_rating"] ?? "",
       review_count: json["review_count"] ?? 0,
      variations: json["variations"] != null ? List<VariationsModel>.from(json["variations"].map((x)=> VariationsModel.fromJson(x))) : [],
       reviews: json["reviews"] != null ? List<ReviewModel>.from(json["reviews"].map((x)=> ReviewModel.fromJson(x))) : []
   );
  }

}

class VariationsModel{
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
  String? mr_price;
  int? available_quantity;
  int? stock_quantity;
  int? status;
  int? has_variations;
  String? key_specifications;
  String? packaging;
  String? warranty;

  VariationsModel({
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
    required this.mr_price,
    required this.available_quantity,
    required this.stock_quantity,
    required this.status,
    required this.has_variations,
    required this.key_specifications,
    required this.packaging,
    required this.warranty,
  });

  factory VariationsModel.fromJson(Map<String, dynamic> json){
    return VariationsModel(
      product_code: json["product_code"] ?? "",
      product_name: json["product_name"] ?? "",
      image_full_url: json["image_full_url"] ?? "",
      main_image_full_url: json["main_image_full_url"] ?? "",
      product_description: json["product_description"] ?? "",
      category_id: json["category_id"] ?? 0,
      delivery_target_days:json["delivery_target_days"] ?? "",
      discount: json["discount"] ?? "",
      actual_price:json["actual_price"] ?? "",
      sell_price: json["sell_price"] ?? "",
      mr_price:json["mr_price"] ?? "",
      available_quantity: json["available_quantity"] ?? 0,
      stock_quantity: json["stock_quantity"] ?? 0,
      status: json["status"] ?? "",
      has_variations: json["has_variations"] ?? 0,
      key_specifications: json["key_specifications"] ?? "",
      packaging: json["packaging"] ?? "",
      warranty: json["warranty"] ?? "",
    );
  }
}

class ReviewModel{
  int id;
  String review_detail;
  ReviewModel({required this.id, required this.review_detail});

  factory ReviewModel.fromJson(Map<String, dynamic> json){
    return ReviewModel(
        id: json['id'] ?? 0,
        review_detail:json['review_detail'] ?? "");
  }
}