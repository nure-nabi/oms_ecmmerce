import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:oms_ecommerce/payment/payment_connectips.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../screen/address/model/address_model.dart';
import '../screen/order/api/order_repo.dart';
import 'generate_uniqid.dart';

Future<void> handleConfirmOrderIPS(
    {required BuildContext context ,
      required payment_method,
      required billing_address,
      required shipping_address,
      required invoice_email,
      required double totalAmount,
      List<String>? selected_items,   // optional
      String? product_code,           // optional
      String? quantity,                  // optional
    }) async {
  final transId = "Tx${generateUniqueId()}";
  final refId = "Rf${generateUniqueId()}";


  final total = int.parse(totalAmount.toString().split('.').first); // NPR

  final MERCHANTID = "3873";
  final APPID = "MER-3873-APP-1";
  final APPNAME = "Garg Dental";
  final CONNECTIPS_API_URL = "https://login.connectips.com/connectipswebgw/loginpage";

  //orderCartSave

  final orderData ;
 // Fluttertoast.showToast(msg: totalAmount.toString().split('.').first);
  late AddressResponse response;
  if(selected_items != null && selected_items.isNotEmpty){
    response =await   OrderRepo.orderCartSave(
        payment_method: payment_method,
        billing_address: billing_address,
        shipping_address: shipping_address,
        invoice_email: invoice_email,
        selected_items: selected_items
    );



    //  orderData = {
    //   "payment_method": payment_method,
    //   "billing_address": billing_address,
    //   "shipping_address": shipping_address,
    //    "token": await GetAllPref.token(),
    //   "invoice_email": invoice_email,
    //   "transaction_id": transId,
    //   "selected_items": selected_items
    // };
  }else{

     response = await OrderRepo.orderSave(
      payment_method: payment_method,
      billing_address: billing_address,
      shipping_address: shipping_address,
      invoice_email: invoice_email,
      product_code: product_code,
      quantity: quantity,
    );

  //  Fluttertoast.showToast(msg: "FFFF");
  //    orderData = {
  //     "payment_method": payment_method,
  //     "billing_address": billing_address,
  //     "shipping_address": shipping_address,
  //     "token": await GetAllPref.token(),
  //     "invoice_email": invoice_email,
  //     "transaction_id": transId,
  //      // "buy_now_item": {
  //      //   "product_code": product_code, "quantity": quantity
  //      // }
  //     "product_code": product_code,
  //     "quantity": quantity,
  //
  //   };
  }



  /// 1️⃣ BUILD ORDER DATA
  // orderData = {
  //   "payment_method": selected,
  //   "billing_address": selectedBillingAddress["id"],
  //   "shipping_address": selectedShippingAddress["id"],
  //   "token": await GetAllPref.token(),
  //   "invoice_email": email,
  //   "transaction_id": transId,
  //   "buy_now_item": {
  //     "product_code": selectedItems[0]["product_code"],
  //     "quantity": selectedItems[0]["quantity"]
  //   }
  // };
  //v1/customer/order/add
  //v1/customer/order/buy-now
  String endPoint = "";
  if(selected_items != null && selected_items.isNotEmpty){
     endPoint =  "v1/customer/order/add" ;
  }else{
     endPoint  = "v1/customer/order/buy-now";
  }


  //print("ORDER DATA → $orderData");
  // final headers = {
  //   'Authorization': 'Bearer ${await GetAllPref.token()}'
  // };
  // final orderRes = await http.post(
  //   Uri.parse("https://gargdental.omsok.com/api/$endPoint"),
  //   headers: headers,
  //   body: jsonEncode(orderData),
  // );

 // if (orderRes.success != 200) {
 //   throw Exception("Order buy now failed");
 // }

  //final orderResult = jsonDecode(orderRes.body);
  //print("ORDER DATA → ${orderResult["order_id"]}");

  /// 3️⃣ BUILD TRANSACTION DETAILS
  final transactionDetails = {
    "MERCHANTID": MERCHANTID,
    "APPID": APPID,
    "APPNAME": APPNAME,
    "TXNID": transId,
    "TXNDATE": DateTime.now().toIso8601String(),
    "TXNCRNCY": "NPR",
    "TXNAMT": (total * 100).toString(), // Convert to paisa
    "REFERENCEID": refId,
    "REMARKS": "Garg dental Services !",
    "PARTICULARS": response.order_id,
    "TOKEN": "TOKEN"
  };

  /// 4️⃣ REQUEST ConnectIPS TOKEN
  final tokenResponse = await http.post(
    Uri.parse("https://dentalnepal.com/connectips/get_token"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(transactionDetails),
  );

  if (tokenResponse.statusCode != 200) {
    throw Exception("Failed to get TOKEN");
  }

  final responseJson = jsonDecode(tokenResponse.body);
  final token = responseJson["TOKEN"];

  //debugPrint('$orderData\n ${orderResult["order_id"]}');
  //Fluttertoast.showToast(msg: token.toString());

  /// MERGE TOKEN
  final payload = {...transactionDetails, "TOKEN": token};

  /// 5️⃣ OPEN WEBVIEW WITH AUTO-SUBMIT FORM
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ConnectIPSWebView(
        url: CONNECTIPS_API_URL,
        payload: payload,
      ),
    ),
  );
}
