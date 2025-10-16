import 'dart:convert';

import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';
import 'package:oms_ecommerce/screen/verification_register/model/verification_model.dart';

import '../../../utils/custom_log.dart';
import '../../service/apiprovider.dart';

class VerificationRepo {

  static Future verification({
    required String code,
    required String email,
  }) async {
    VerificationReqModel verificationReqModel = VerificationReqModel(
        verificationCode: code, email: email
        );
     // var body = jsonEncode({
     //       "user_verification_code": code,
     //       "email": email,
     // });
    var body = jsonEncode(verificationReqModel.toJson());

    var jsonData = await APIProvider.postAPI(
      endPoint: "v1/verify-account",
      body: body,
    );
    CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return VerificationResModel.fromJson(jsonData);
  }

}
