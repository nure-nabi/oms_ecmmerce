import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/service/apiprovider.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../../basic_model/basic_model.dart';
import '../model/offer_model.dart';


class OfferRepo{

  static Future getOffer() async{
 var jsonData =  await  APIProvider.getAPI(
     endPoint: "v1/offers");

  CustomLog.successLog(value: "OfferResp $jsonData" );

 return OfferResp.fromJson(jsonData);

  }


}