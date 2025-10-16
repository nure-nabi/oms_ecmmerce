import 'dart:convert';

class ProductDetailsReqModel{

  ProductDetailsResModel ? productDetailsResModel;
  ProductDetailsReqModel({required this.productDetailsResModel});

   factory ProductDetailsReqModel.fromJson(Map<String,dynamic> json){
     return ProductDetailsReqModel(
       //user: json["data"] != null ? UserModel.fromJson(json["data"]) : null,
         productDetailsResModel: json['product'] != null ? ProductDetailsResModel.fromJson(json['product']) : ProductDetailsResModel.fromJson({})
     );
   }

  // Map<String, dynamic> toJson() =>{
  //   "productCode":productCode,
  // };
}

class ProductDetailsResModel{
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
  List<ReviewModel> reviews;
  List<String>? filesFullUrl;
  List<VariationsModel> variations;

  ProductDetailsResModel({
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
    required this.filesFullUrl,
    required this.average_rating,
    required this.review_count,
    required this.variations,
    required this.reviews,

});

  factory ProductDetailsResModel.fromJson(Map<String, dynamic> json){
    return ProductDetailsResModel(
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
        filesFullUrl: json['files_full_url'] != null ? List<String>.from(json['files_full_url']) : [],
        reviews: json["reviews"] != null ? List<ReviewModel>.from(json["reviews"].map((x)=> ReviewModel.fromJson(x))) : [],
        variations: json["variations"] != null ? List<VariationsModel>.from(json["variations"].map((x)=> VariationsModel.fromJson(x))) : []
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
// class VariationModel{
//   int? id;
//   String? product_code;
//   //String? attributes;
//   final Map<String, dynamic> attributes;
//   String? price;
//   int? stock;
//
//   VariationModel({required this.id,required this.product_code,required this.attributes,required this.price,required this.stock});
//
//   factory VariationModel.fromJson(Map<String, dynamic> json){
//     var productImageJson = json['attributes'] != null ? json['attributes'] : null;
//     return VariationModel(
//         id: json["id"] ?? 0,
//         product_code: json["product_code"] ?? "",
//         attributes: json['attributes'] is String
//             ? Map<String, dynamic>.from(jsonDecode(json['attributes']))
//             : Map<String, dynamic>.from(json['attributes']),
//         // attributes: productImageJson != null
//         //     ? VariationDetails.fromJson(productImageJson)
//         //     : null,
//         price: json["price"] ?? "",
//         stock: json["stock"] ?? 0
//     );
//   }
// }
//
// class VariationDetails {
//
//   Attributes? attributes;
//
//   VariationDetails({ this.attributes});
//
//   factory VariationDetails.fromJson(Map<String, dynamic> json) {
//     return VariationDetails(
//       attributes: json['attributes'] != null
//           ? Attributes.fromJson(json['attributes'])
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       if (attributes != null) 'attributes': attributes!.toJson(),
//     };
//   }
// }
//
// class Attributes {
//   String attributes;
//
//   Attributes({required this.attributes});
//
//   factory Attributes.fromJson(Map<String, dynamic> json) {
//     return Attributes(attributes: json['attributes']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'attributes': attributes};
//   }
// }