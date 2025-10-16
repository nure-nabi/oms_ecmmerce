import 'dart:convert';

import 'package:oms_ecommerce/screen/service/apiprovider.dart';

import '../../../basic_model/basic_model.dart';

class ContactUsRepo{

  static Future saveContactUs({
    required name,
    required email,
    required message
}) async{
     var body = jsonEncode({
       'name':name,
       'email': email,
       'message':message
     });

 var jsonData = await     APIProvider.postAPI(
         endPoint: "v1/contact-us",
         body: body
     );

 return BasicModel.fromJson(jsonData);
  }
}