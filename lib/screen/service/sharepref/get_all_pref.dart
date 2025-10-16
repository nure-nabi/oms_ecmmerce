import 'dart:convert';

import 'pref_text.dart';
import 'share_preference.dart';

class GetAllPref {

  static loginSuccess() async {
    return await SharedPref.getData(
      key: PrefText.loginSuccess,
      dValue: false,
      type: "bool",
    );
  }
  static userId() async {
    return await SharedPref.getData(
      key: PrefText.userId,
      dValue: "_",
      type: "String",
    );
  }
  static userEmail() async {
    return await SharedPref.getData(
      key: PrefText.email,
      dValue: "_",
      type: "String",
    );
  }
  static token() async {
    return await SharedPref.getData(
      key: PrefText.token,
      dValue: "_",
      type: "String",
    );
  }
  static verificationCode() async {
    return await SharedPref.getData(
      key: PrefText.verificationCode,
      dValue: "_",
      type: "String",
    );
  }

  static verificationEmail() async {
    return await SharedPref.getData(
      key: PrefText.verificationEmail,
      dValue: "_",
      type: "String",
    );
  }


}
