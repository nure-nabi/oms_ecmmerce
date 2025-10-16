class AddReqCart{
  String? product_code;
  String?  price;
  String?  quantity;
  AddReqCart({required this.product_code,required this.price,required this.quantity});

  Map<String, dynamic> toJson() =>{
    "product_code":product_code,
    "price":price,
    "quantity":quantity,
  };
}

class AddResCart{
  bool? success;
  String? message;
  AddResCart({required this.success, required this.message});

  factory AddResCart.fromJson(Map<String, dynamic> json){
    return AddResCart(
        success: json["success"] ?? false,
        message: json["message"] ?? "");
  }
}