class BrandProductResModel{
  bool success;
  String message;
  List<BrandProductModel> products;
  BrandProductResModel({required this.products,required this.success,required this.message});

  factory BrandProductResModel.fromJson(Map<String,dynamic> json){
    return BrandProductResModel(
    success: json['success'] ?? false,
    message: json['message'] ?? "",
      products: json["products"] != null
          ? List<BrandProductModel>.from(
          json["products"].map((x) => BrandProductModel.fromJson(x)))
          : [],
    );
  }
}


class BrandProductModel{
  String? product_code;
  String? product_name;
  String? image_full_url;
  String? main_image_full_url;
  String? main_image;
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
  String? average_rating;
  bool? is_wishlisted;
  int? review_count;
  List<VariationsModel>? variations;
  List<ReviewModel>? reviews;

  BrandProductModel({
     this.product_code,
     this.product_name,
     this.image_full_url,
     this.main_image_full_url,
     this.main_image,
     this.product_description,
     this.category_id,
     this.delivery_target_days,
     this.discount,
     this.actual_price,
     this.sell_price,
     this.mr_price,
     this.available_quantity,
     this.stock_quantity,
     this.flash_sale,
     this.status,
     this.is_wishlisted,
     this.has_variations,
     this.key_specifications,
     this.packaging,
     this.warranty,
     this.starting_price,
     this.average_rating,
     this.review_count,
     this.variations,
     this.reviews,
  });

// 👇 This is the copyWith method
  BrandProductModel copyWith({
    String? product_code,
    bool? is_wishlisted,
  }) {
    return BrandProductModel(
      product_code: product_code ?? this.product_code,
      product_name: product_name ?? this.product_name,
      image_full_url: image_full_url,
      main_image_full_url: main_image_full_url,
      product_description: product_description,
      main_image: main_image,
      category_id: category_id,
      delivery_target_days: delivery_target_days,
      discount: discount,
      actual_price: actual_price,
      sell_price: sell_price,
      mr_price: mr_price,
      available_quantity: available_quantity,
      stock_quantity: stock_quantity,
      flash_sale: flash_sale,
      status: status,
      has_variations: has_variations,
      key_specifications: key_specifications,
      packaging: packaging,
      warranty: warranty,
      starting_price: starting_price,
      average_rating: average_rating,
      review_count: review_count,
      variations: variations,
      reviews: reviews,
      is_wishlisted: is_wishlisted ?? this.is_wishlisted,
    );
  }

  factory BrandProductModel.fromJson(Map<String, dynamic> json){
   return BrandProductModel(
     product_code: json["product_code"] ?? "",
     product_name: json["product_name"] ?? "",
     image_full_url: json["image_full_url"] ?? "",
     main_image_full_url: json["main_image_full_url"] ?? "",
       main_image: json["main_image"] ?? "",
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
       average_rating: json["average_rating"] ?? "",
       is_wishlisted: json["is_wishlisted"] ?? false,
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