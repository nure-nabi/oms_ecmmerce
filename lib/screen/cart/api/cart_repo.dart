import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/cart/model/add_cart.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../service/apiprovider.dart';
import '../model/cart_model.dart';


class CartRepo{
  static Future getCart({required userId}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/customer/cart/list",
    );
    CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return CartResModel.fromJson(jsonData);
  }

  static Future addCart({
    required String product_code,
    required String price,
    required String quantity,
  }) async {
    AddReqCart addReqCart = AddReqCart(product_code: product_code, price: price, quantity: quantity);
    //  var body = jsonEncode({
    //        "product_code": email,
    //        "price": password,
    //        "quantity": password,
    //  });
    //
    var body = jsonEncode(addReqCart.toJson());

    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/customer/cart/add",
      body: body,
    );
   // CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return AddResCart.fromJson(jsonData);
  }

  static Future deleteCartByItemCode({
    required int item_id,

  }) async {
     var body = jsonEncode({
           "item_id": item_id.toString(),
     });

    var jsonData = await APIProvider.deleteAPI(
      endPoint: "v1/customer/cart/remove-item",
      body: body,
    );
    CustomLog.successLog(value: "item removed Save Data => $jsonData");
    return CartItemRemovedResModel.fromJson(jsonData);
  }
  static Future clearCart() async {
    var body = jsonEncode({
      "": "",
    });

    var jsonData = await APIProvider.deleteAPI(
      endPoint: "v1/customer/cart/remove",
      body: body,
    );
    CustomLog.successLog(value: "item removed Save Data => $jsonData");
    return CartItemRemovedResModel.fromJson(jsonData);
  }



  static Future updateCart({
    required String item_id,
    required String quantity,
  }) async {
     var body = jsonEncode({
            "item_id": item_id,
            "quantity": quantity,
     });


    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/customer/cart/update",
      body: body,
    );
    CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return CartItemRemovedResModel.fromJson(jsonData);
  }
} //192.168.1.64:8000/api/v1/customer/cart/update