import 'dart:convert';

import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';

import '../../../utils/custom_log.dart';
import '../../service/apiprovider.dart';

class RegisterAPI {

  static Future<RegisterResModel> register({
    required String firstName,
    required String lastName,
    required String password,
    required String phone,
    required String email,
  }) async {
    try {
      final registerReqModel = RegisterReqModel(
        firstName: firstName,
        lastName: lastName,
        password: password,
        phone: phone,
        email: email,
      );

      final body = jsonEncode(registerReqModel.toJson());

      final jsonData = await APIProvider.postAPI(
        endPoint: "v1/register",
        body: body,
      );

      if (jsonData == null) {
        // 🚫 No response case
        return RegisterResModel(
          code: 500,
          email: "",
          errors: [ValidationError(message: "No response from server", code: '')],
        );
      }

      if (jsonData["success"] == true) {
        // ✅ Registration success
        CustomLog.successLog(value: "RESPONSE register => $jsonData");
        return RegisterResModel.fromJson(jsonData);
      } else {
        // ⚠️ Registration failed – map error into the model
        CustomLog.errorLog(value: "Registration failed => ${jsonData["message"]}");

        return RegisterResModel(
          code: jsonData["code"] ?? 400,
          email: "",
          errors: [
            ValidationError(message: jsonData["message"] ?? "Something went wrong", code: '')
          ],
        );
      }
    } catch (e) {
      // ⚠️ Exception case
      CustomLog.errorLog(value: "Exception in register(): $e");

      return RegisterResModel(
        code: 500,
        email: "",
        errors: [ValidationError(message: e.toString(), code: '')],
      );
    }
  }



}
