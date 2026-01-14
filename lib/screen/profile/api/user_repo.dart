

import 'dart:convert';



import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../basic_model/basic_model.dart';
import '../../../utils/custom_log.dart';

import '../../service/apiprovider.dart';
import '../../service/sharepref/get_all_pref.dart';
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

    Map<String, dynamic> body = image != "" ? {
      "full_name": full_name,
      "phone": phone,
      "profile_photo_path": image

    } : { "full_name": full_name,
      "phone": phone,

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

  static Future removedAccount() async {
    var jsonData = await APIProvider.deleteAPI(
      endPoint: "v1/customer/remove-account",
    );
    String apiUrl = 'https://gargdental.omsok.com/api/v1/customer/remove-account';
    http.Response response = await http
        .delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await GetAllPref.token()}'
      },
    ).timeout(const Duration(seconds: 50));


    CustomLog.successLog(value: "RESPONSE  info => ${response.body}");
    return BasicModel.fromJson(jsonDecode(response.body));
  }

  //   CustomLog.successLog(value: "RESPONSE customer info => $jsonData");
  //   return BasicModel2.fromJson(jsonData);
  // }

//https://gargdental.omsok.com/api/v1/customer/remove-account
}