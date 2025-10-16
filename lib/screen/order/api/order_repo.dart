// https://gargdental.omsok.com/api/v1/customer/order/buy-now
//
//     {
// "payment_method": "C",
// "billing_address": 2,
// "shipping_address": 2,
// "invoice_email": "jananpandey1995@gmail.com",
// "buy_now_item": {
// "product_code": "A500002",
// "quantity": 3
// }
// }

import 'dart:convert';

import 'package:oms_ecommerce/basic_model/basic_model.dart';
import 'package:oms_ecommerce/screen/address/model/address_model.dart';
import 'package:oms_ecommerce/screen/cart/model/cart_model.dart';
import 'package:oms_ecommerce/screen/service/apiprovider.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../model/order_model.dart';
import '../model/reason_model.dart';

class OrderRepo {
  static Future getOrder({required status}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/customer/order/list?status=$status",
    );
    CustomLog.successLog(value: "RESPONSE order list => $jsonData");
   return OrderResponseModel.fromJson(jsonData);
  }

  static Future orderSave({
    required payment_method,
    required billing_address,
    required shipping_address,
    required invoice_email,
    required product_code,
    required quantity,
  }) async {
    var body = jsonEncode({
      "payment_method": payment_method,
      "billing_address": billing_address,
      "shipping_address": shipping_address,
      "invoice_email": invoice_email,
      "buy_now_item": {
        "product_code": product_code, "quantity": quantity
      }
    });

    //https://gargdental.omsok.com/api/v1/customer/order/buy-now
    var jsonData = await APIProvider.postAPI(
        endPoint: "v1/customer/order/buy-now", body: body);

    CustomLog.successLog(value: "save order=>  ${jsonData}");
    return AddressResponse.fromJson(jsonData);
  }

  static Future orderCartSave({
    required payment_method,
    required billing_address,
    required shipping_address,
    required invoice_email,
    required selected_items,
  }) async {
    var body = jsonEncode({
      "payment_method": payment_method,
      "billing_address": billing_address,
      "shipping_address": shipping_address,
      // "subtotal": subtotal,
      // "shipping": shipping,
      // "grandtotal": grandtotal,
      "invoice_email": invoice_email,
      "selected_items": selected_items
    });

    //https://gargdental.omsok.com/api/v1/customer/order/buy-now
    var jsonData = await APIProvider.postAPI(
        endPoint: "v1/customer/order/add", body: body);

    CustomLog.successLog(value: "save order through by cart=>  ${jsonData}");
    return AddressResponse.fromJson(jsonData);
  }


  static Future getReason() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/customer/order/reasons-list",
    );
    CustomLog.successLog(value: "RESPONSE ReasonResponse list => $jsonData");
    return ReasonResponse.fromJson(jsonData);
  }

  static Future reasonSave({
    required orderId,
    required reasonId,
    required description,
    required check,

  }) async {
    var body = jsonEncode({
      "order_id": orderId,
      "reason_id": reasonId,
      "reason_description": description,
      "policy_checked": check == true ? "Y" : "No"
    });

    //https://gargdental.omsok.com/api/v1/customer/order/cancel
    var jsonData = await APIProvider.postAPI(
        endPoint: "v1/customer/order/cancel",
        body: body);

    CustomLog.successLog(value: "order/cancel=>  ${jsonData}");
    return AddressResponse.fromJson(jsonData);
  }

  static Future saveReviewRating({
    required rating,
    required review_detail,
    required product_code,
    required order_id,
  })async{
   var body = jsonEncode({
     'rating':rating,
     'review_detail':review_detail,
     'product_code':product_code,
     'order_id':order_id,
   });

   var jsonData =await APIProvider.postAPI(
       endPoint: "v1/customer/reviews/add",
       body: body);

   return BasicModel.fromJson(jsonData);
  }
}
