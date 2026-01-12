import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/service/apiprovider.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../../basic_model/basic_model.dart';
import '../model/privacy_policy_model.dart';

class PrivacyPolicyRepo{

  static Future getPrivacyPolicy() async{
 var jsonData =  await  APIProvider.getAPI(
     endPoint: "v1/compliances");

  CustomLog.successLog(value: "Data policy $jsonData" );

 return PrivacyPolicyRes.fromJson(jsonData);

  }

  //https://gargdental.omsok.com/api/v1/customer/grievance

static Future saveComplain({
    required name,
    required email,
    required city,
    required phone,
    required remarks,
    required imagePath,
}) async{

  // Create the body (without jsonEncode yet)
  Map<String, dynamic> body = {
    "name": name,
    "email": email,
    "city": city,
    "phone": phone,
    "remarks": remarks,
    "document": [imagePath], // This will trigger the toast
  };

  String encodedBody = jsonEncode(body);

  // Show toast if 'document' exists (before API call)
  // if (body.containsKey('document')) {
  //   Fluttertoast.showToast(
  //     msg: "Image attached: ${body['document']}",
  //     toastLength: Toast.LENGTH_SHORT,
  //   );
  // }

   // var body = jsonEncode({
   //    'name':name,
   //    'email':email,
   //    'city':city,
   //    'phone':phone,
   //    'remarks':remarks,
   //    'document':imagePath,
   //  });

 var jsonData = await  APIProvider.postAPI(
       endPoint: 'v1/customer/grievance',
       body: encodedBody
   );

 return BasicModel.fromJson(jsonData);

}

}