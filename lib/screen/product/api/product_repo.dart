import 'dart:convert';

import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../model/base_model.dart';
import '../../service/apiprovider.dart';
import '../../singup/model/register_model.dart';
import '../model/latest_product_model.dart';
import '../model/product_details_model.dart';
import '../model/recommended_product_model.dart';

//192.168.1.64:8000/api/v1/customer/cart/add

class ProductRepo{

  static Future getAllProduct({required limit,required offset}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/all?limit=${limit}&offset=${offset}",
    );
    return LatestProductResModel.fromJson(jsonData);
  }
  static Future getLatestProduct() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/latest",
    );
    return LatestProductResModel.fromJson(jsonData);
  }

  static Future getProductDetails({required productCode}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/details/$productCode",
    );
    CustomLog.successLog(value: "RESPONSE getProductDetails => $jsonData");
    return ProductDetailsReqModel.fromJson(jsonData);
  }


  static Future getProductAddRecommended({required productCode}) async {
    var jsonData = await APIProvider.getPostAPI(
      endPoint: "v1/customer/products/add-recommended/$productCode",
    );
  //  CustomLog.successLog(value: "RESPONSE getProductAddRecommended => $jsonData");
    return BaseModel.fromJson(jsonData);
  }

  static Future getProductRecommended() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/customer/products/recommended",
    );
    CustomLog.successLog(value: "RESPONSE recommended => $jsonData");
    return RecommendedProductResModel.fromJson(jsonData);
  }



}
// https://garg.omsok.com/api/v1/customer/products/add-recommended/{product_code}
//
// https://garg.omsok.com/api/v1/customer/products/recommended