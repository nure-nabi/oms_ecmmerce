

import 'dart:convert';

import '../../../utils/custom_log.dart';

import '../../service/apiprovider.dart';
import '../model/user_model.dart';

class UserRepo{
  //http://192.168.1.64:8000/api/v1/customer/update-profile

  static Future getProfile() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/customer/info",
    );
    CustomLog.successLog(value: "RESPONSE customer info => $jsonData");
    return UserInfoResMode.fromJson(jsonData);
  }

  static Future updateProfile({
    required String full_name,
    required String phone,
    required String image,
  }) async {

    Map<String, dynamic> body = {
      "full_name": full_name,
      "phone": phone,
      "profile_photo_path": image

    };

     // var body = jsonEncode({
     //       "full_name": full_name,
     //       "phone": phone,
     //       "profile_photo_path": image
     // });

    var jsonData = await APIProvider.postAPI2(
      endPoint: "v1/customer/update-profile",
      body: body,
    );
    CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return UserInfoResMode.fromJson(jsonData);
  }


}