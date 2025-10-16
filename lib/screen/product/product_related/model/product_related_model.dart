class ProductRelatedResModel {

  bool success;
  String message;
  List<ProductRelatedModel> data;

  ProductRelatedResModel({required this.success, required this.message, required this.data});

  factory ProductRelatedResModel.fromJson(Map<String, dynamic> json){
    return ProductRelatedResModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
      data: json["related_products"] != null
          ? List<ProductRelatedModel>.from(
          json["related_products"].map((x) => ProductRelatedModel.fromJson(x)))
          : [],
    );
  }

}

class ProductRelatedModel{
  String? product_code;
  String? product_name;
  String? image_full_url;
  String? product_description;
  int? category_id;
  String? delivery_target_days;
  String? discount;
  String? actual_price;
  String? sell_price;

  int? available_quantity;
  int? stock_quantity;
  int? status;

  ProductRelatedModel({
    required this.product_code,
    required this.product_name,
    required this.image_full_url,
    required this.product_description,
    required this.category_id,
    required this.delivery_target_days,
    required this.discount,
    required this.actual_price,
    required this.sell_price,

    required this.available_quantity,
    required this.stock_quantity,
    required this.status,});

  factory ProductRelatedModel.fromJson(Map<String, dynamic> json){
    return ProductRelatedModel(
      product_code: json["product_code"] ?? "",
      product_name: json["product_name"] ?? "",
      image_full_url: json["image_full_url"] ?? "",
      product_description: json["product_description"] ?? "",
      category_id: json["category_id"] ?? 0,
      delivery_target_days:json["delivery_target_days"] ?? "",
      discount: json["discount"] ?? "",
      actual_price:json["actual_price"] ?? "",
      sell_price: json["sell_price"] ?? "",

      available_quantity: json["available_quantity"] ?? 0,
      stock_quantity: json["stock_quantity"] ?? 0,
      status: json["status"] ?? 0,);
  }

}