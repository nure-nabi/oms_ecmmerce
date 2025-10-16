class OrderResponseModel {
  bool success;
  String message;
  Orders orders;

  OrderResponseModel(
      {required this.success, required this.message, required this.orders});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json){
    return OrderResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        orders: json["orders"] != null ? Orders.fromJson(json["orders"]) : Orders.fromJson({})
    );
  }
}


class Orders{
  int? count;
  List<OrderModel> orders;
  Orders({required this.count,required this.orders});

  factory Orders.fromJson(Map<String,dynamic> json){
    return Orders(
        count: json["count"] ?? 0,
        orders: json["orders"] != null
            ?
        List<OrderModel>.from(json["orders"].map((x) => OrderModel.fromJson(x)))
            : []
    );
  }
}


class OrderModel {
  int? id;
  int? order_id;
  int? customer_id;
  int? shipping_delivery_information_id;
  int? billing_delivery_information_id;
  String? payment_method;
  String? subtotal;
  String? shipping_cost;
  String? discount;
  String? total_amount;
  String? order_status;
  String? payment_status;
  List<OrderItemModel> orderItems;

  OrderModel({
    required this.id,
    required this.order_id,
    required this.customer_id,
    required this.shipping_delivery_information_id,
    required this.billing_delivery_information_id,
    required this.payment_method,
    required this.subtotal,
    required this.shipping_cost,
    required this.discount,
    required this.total_amount,
    required this.order_status,
    required this.payment_status,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json){
    return OrderModel(
      id: json["id"] ?? 0,
      order_id: json["order_id"] ?? 0,
      customer_id: json["customer_id"] ?? 0,
      shipping_delivery_information_id: json["shipping_delivery_information_id"] ??
          0,
      billing_delivery_information_id: json["billing_delivery_information_id"] ??
          0,
      payment_method: json["payment_method"] ?? "",
      subtotal: json["subtotal"] ?? "",
      shipping_cost: json["shipping_cost"] ?? "",
      discount: json["discount"] ?? "",
      total_amount: json["total_amount"] ?? "",
      order_status: json["order_status"] ?? "",
      payment_status: json["payment_status"] ?? "",
      orderItems: json["order_items"] != null ? List<OrderItemModel>.from(json["order_items"].map((x)=> OrderItemModel.fromJson(x))) : []
    );
  }
}

class OrderItemModel {
  int? id;
  int? order_id;
  String? product_code;
  int? quantity;
  String? price;
  String? actual_price;
  String? mr_price;
  String? subtotal;
  String? shipping_cost;
  String? discount;
  int? reviewed;
  ProductsModel? productsModel;

  OrderItemModel({
    required this.id,
    required this.order_id,
    required this.product_code,
    required this.quantity,
    required this.price,
    required this.actual_price,
    required this.mr_price,
    required this.subtotal,
    required this.shipping_cost,
    required this.discount,
    required this.reviewed,
    required this.productsModel,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json){
    return OrderItemModel(
        id: json["id"] ?? 0,
        order_id: json["order_id"] ?? 0,
        product_code: json["product_code"] ?? "",
        quantity: json["quantity"] ?? 0,
        price: json["price"] ?? "",
        actual_price: json["actual_price"] ?? "",
        mr_price: json["mr_price"] ?? "",
        subtotal: json["subtotal"] ?? "",
        reviewed: json["reviewed"] ?? 0,
        shipping_cost: json["shipping_cost"] ?? "",
        discount: json["discount"] ?? "",
        productsModel: json["product"] != null ? ProductsModel.fromJson(json["product"]) : ProductsModel.fromJson({})
    );
  }
}

class ProductsModel {
  int? id;
  String? product_code;
  String? product_name;
  String? slug;
  String? product_description;
  String? delivery_target_days;
  String? actual_price;
  String? sell_price;
  String? mr_price;
  String? image_full_url;
  String? main_image_full_url;

  ProductsModel({
    required this.id,
    required this.product_code,
    required this.product_name,
    required this.slug,
    required this.product_description,
    required this.delivery_target_days,
    required this.actual_price,
    required this.sell_price,
    required this.mr_price,
    required this.image_full_url,
    required this.main_image_full_url,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json){
    return ProductsModel(
        id: json["id"] ?? 0,
        product_code: json["product_code"] ?? "",
        product_name: json["product_name"] ?? "",
        slug: json["slug"] ?? "",
        product_description: json["product_description"] ?? "",
        delivery_target_days: json["delivery_target_days"] ?? "",
        actual_price: json["actual_price"] ?? "",
        sell_price: json["sell_price"] ?? "",
        mr_price: json["mr_price"] ?? "",
         image_full_url: json["image_full_url"] ?? "",
      main_image_full_url: json["main_image_full_url"] ?? "",
    );
  }
}