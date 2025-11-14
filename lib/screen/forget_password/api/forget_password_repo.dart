import 'dart:convert';

import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';

import '../../../basic_model/basic_model.dart';
import '../../../utils/custom_log.dart';
import '../../service/apiprovider.dart';
import '../model/forget_password_model.dart';

class ForgetPasswordRepo {

  static Future forgetPassword({
    required String email,
  }) async {
     var body = jsonEncode({
           "email": email,
     });
    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/auth/forgot-password-code",
      body: body,
    );
    return ForgetPasswordResp.fromJson(jsonData);
  }

  static Future changePassword({
    required String oldPassword,
    required String newPassword,
    required String newConfirm,
  }) async {
    var body = jsonEncode({
      "current_password": oldPassword,
      "new_password": newPassword,
      "new_password_confirmation": newConfirm,
    });
    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/customer/change-password",
      body: body,
    );

    return BasicModel.fromJson(jsonData);
  }

//POST https://gargdental.omsok.com/api/v1/auth/reset-password-verify HTTP/1.1
}
