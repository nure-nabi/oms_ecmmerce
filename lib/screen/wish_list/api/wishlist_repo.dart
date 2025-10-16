//POST https://gargdental.omsok.com/api/v1/customer/wishlist/add

// {
// "product_code" : "A00004"
// }


//###wishlist get
// GET https://gargdental.omsok.com/api/v1/customer/wishlist/list


//###remove item wishlst
// DELETE https://gargdental.omsok.com/api/v1/customer/wishlist/remove-item

// {
// "item_id" : "19"
// }

import 'dart:convert';

import 'package:oms_ecommerce/screen/service/apiprovider.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../../basic_model/basic_model.dart';
import '../model/wishlsit_model.dart';

class WishlistRepo{

  static Future saveWishList({required productId}) async{
    final body = jsonEncode({
      'product_code':productId
    });
  final jsonData = await  APIProvider.postAPI(
      endPoint: "v1/customer/wishlist/add",
      body: body);
  CustomLog.successLog(value: "Wish list $jsonData");
  return BasicModel.fromJson(jsonData);

  }

  static Future getWishList()async{
  final jsonData = await  APIProvider.getAPI(
      endPoint: "v1/customer/wishlist/list"
  );
  CustomLog.successLog(value: "Wish list $jsonData");
  return WishlistResponse.fromJson(jsonData);
  }

  static Future removeWishList({required item_id})async{
    var body = jsonEncode({
      'item_id': item_id
    });
    final jsonData = await  APIProvider.postSingleAPI(
        endPoint: "v1/customer/wishlist/remove-item?item_id=${item_id}",
        method: 'Delete'
    );
    CustomLog.successLog(value: "Wish list removed data $jsonData");
    return BasicModel.fromJson(jsonData);
  }

}
