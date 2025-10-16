import 'dart:convert';

import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';

import '../../../utils/custom_log.dart';
import '../../service/apiprovider.dart';

class RegisterAPI {

  static Future register({
    required String firstName,
    required String lastName,
    required String password,
    required String phone,
    required String email,
  }) async {
    RegisterReqModel registerReqModel = RegisterReqModel(
        firstName: firstName,
        lastName: lastName,
        password: password,
        phone: phone,
        email: email);

    //  var body = jsonEncode({
    //        "email": email,
    //        "password": password,
    //  });
    // CustomLog.successLog(value: "RESPONSE Save Data => $loginReqModel.toJson()");
    var body = jsonEncode(registerReqModel.toJson());

    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/register",
      body: body,
    );

    return RegisterResModel.fromJson(jsonData);
  }

}
