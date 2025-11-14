import 'dart:convert';

import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';

import '../../../basic_model/basic_model.dart';
import '../../../utils/custom_log.dart';
import '../../service/apiprovider.dart';


class ResetPasswordRepo {

  static Future resetPassword({
    required String email,
    required String reset_code,
    required String new_password,
    required String confirm_new_password,
  }) async {
    var body = jsonEncode({
      "email": email,
      "reset_code": reset_code,
      "new_password": new_password,
      "confirm_new_password": confirm_new_password,
    });
    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/auth/reset-password-verify",
      body: body,
    );
    CustomLog.successLog(value: "RESPONSE forget Data => $body");
    return BasicModel.fromJson(jsonData);
  }
//POST https://gargdental.omsok.com/api/v1/auth/reset-password-verify HTTP/1.1
}
