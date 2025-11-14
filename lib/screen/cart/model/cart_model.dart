import 'package:oms_ecommerce/screen/cart/bloc/cart_event.dart';

class CartResModel{
  Cart? cart;
  CartResModel({required this.cart});

  factory CartResModel.fromJson(Map<String,dynamic> json){
    return CartResModel(
      cart: json["cart"] != null ? Cart.fromJson(json["cart"]) : null,
    );
  }
}

class Cart{
  int? customer_id;
  int? province_id;
  List<CartItemModel> items;

  Cart({required this.customer_id,required this.province_id,required this.items});

  factory Cart.fromJson(Map<String, dynamic> json){
    return Cart(
        customer_id: json["customer_id"] ?? 0,
        province_id: json["province_id"] ?? 0,
      items: json["items"] != null
          ? List<CartItemModel>.from(
          json["items"].map((x) => CartItemModel.fromJson(x)))
          : [],
    );
    }

}



class CartItemModel{
  int? id;
  int? cart_id;
  String? product_code;
  int? quantity;
  String? price;
  CartProductModel? products;

  CartItemModel({required this.id, required this.cart_id, required this.product_code,
    required this.quantity, required this.price,required this.products});

  factory CartItemModel.fromJson(Map<String,dynamic> json){
    return CartItemModel(
      id: json["id"] ?? 0,
      cart_id: json["cart_id"] ?? 0,
      product_code: json["product_code"] ?? "",
      quantity: json["quantity"] ?? 0,
      price: json["price"] ?? "",
      products: json["product"] != null ? CartProductModel.fromJson(json["product"]) : null,
    );
  }


}



class CartProductModel{
  String? product_code;
  String? product_name;
  String? actual_price;
  String? sell_price;
  String? stock_quantity;
  String? mr_price;
  String? quantity;
  String? product_description;
  String? image_full_url;
  String? main_image;
  String? main_image_full_url;

  CartProductModel({required this.product_code,
    required this.product_name,
    required this.actual_price,
    required this.sell_price,
    required this.stock_quantity,
    required this.mr_price,
     this.quantity,
    required this.product_description,
    required this.image_full_url,
     this.main_image,
    required this.main_image_full_url,
  });

  factory CartProductModel.fromJson(Map<String,dynamic> json){
    return CartProductModel(
        product_code: json["product_code"] ?? "",
        product_name: json["product_name"] ?? "",
      actual_price: json["actual_price"] ?? "",
      sell_price: json["sell_price"] ?? "",
      stock_quantity: json["stock_quantity"] != null ? json["stock_quantity"] .toString() : "0",
      mr_price: json["mr_price"] ?? "",
      quantity: json["quantity"] ?? "",
        product_description: json["product_description"] ?? "",
        image_full_url: json["image_full_url"] ?? "",
      main_image: json["main_image"] ?? "",
      main_image_full_url: json["main_image_full_url"] ?? "",
    );
  }
}

class CartItemRemovedResModel{
  bool? success;
  String? message;
  CartItemRemovedResModel({required this.success,required this.message});

  factory CartItemRemovedResModel.fromJson(Map<String,dynamic> json){
    return CartItemRemovedResModel(
        success: json["success"] ?? false,
        message:json["message"] ?? "",
    );
  }
}