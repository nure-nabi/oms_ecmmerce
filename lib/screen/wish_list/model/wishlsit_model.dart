
class WishlistResponse{
 bool success;
 String message;
 List<WishlistModel> wishlist;
 WishlistResponse({required this.success, required this.message,required this.wishlist});

 factory WishlistResponse.fromJson(Map<String,dynamic> json){
   return WishlistResponse(
       success: json['success'] ?? false,
       message: json['message'] ?? "",
       wishlist: json['wishlist'] != null ? List<WishlistModel>.from(json['wishlist'].map((x)=> WishlistModel.fromJson(x))) : []
   );
 }
}

class WishlistModel{
  int? id;
  String? product_code;
  ProductModel? productModel;

  WishlistModel({required this.id, required this.product_code,required this.productModel});

  factory WishlistModel.fromJson(Map<String, dynamic> json){
    return WishlistModel(
        id: json['id'] ?? 0,
        product_code: json['product_code'] ?? "",
        productModel: json['product'] != null ? ProductModel.fromJson(json['product']) : ProductModel.fromJson({})
    );
  }
}

class ProductModel {
  String? product_name;
  String? sell_price;
  String? image_full_url;
  String? stock_quantity;
  String? main_image_full_url;

  ProductModel({required this.sell_price,required this.product_name,
    required this.image_full_url,required this.stock_quantity,required this.main_image_full_url});

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
        product_name: json['product_name'] ?? "",
         sell_price: json['sell_price'] == null ? "0.0" : json['sell_price'].toString(),
        stock_quantity: json['stock_quantity'] == null ? "0" : json['stock_quantity'].toString(),
        main_image_full_url: json['main_image_full_url'] ?? "",
        image_full_url: json['image_full_url'] ?? "",
       // image_full_url: json['image_full_url'] ?? ""
        );
  }

}