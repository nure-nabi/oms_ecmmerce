

import 'dart:convert';

import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';

import '../../../utils/custom_log.dart';
import '../../service/apiprovider.dart';

class LoginAPI {

  static Future login({
    required String email,
    required String password,
  }) async {
    LoginReqModel loginReqModel = LoginReqModel(email:email, password: password);
   //  var body = jsonEncode({
   //        "email": email,
   //        "password": password,
   //  });
   // CustomLog.successLog(value: "RESPONSE Save Data => $loginReqModel.toJson()");
    var body = jsonEncode(loginReqModel.toJson());

    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/auth/login",
      body: body,
    );

    return LoginRespModel.fromJson(jsonData);
  }

  static Future loginGoogleRegister({
    required String token,
    required String unique_id,
    required String access_token,
  }) async {
    // LoginReqModel loginReqModel = LoginReqModel(email:email, password: password);
    // var body = jsonEncode(loginReqModel.toJson());

  var  body = jsonEncode(
      {
        'token': token,
        'unique_id': unique_id,
        'access_token': 0,
      }
  );

    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/auth/social/google-register",
      body: body,
    );

    return LoginRespModel.fromJson(jsonData);
  }

  //https://gargdental.omsok.com/api/v1/auth/social/google-register
}
