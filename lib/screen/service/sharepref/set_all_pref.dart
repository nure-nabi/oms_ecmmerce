import 'dart:convert';


import 'sharepref.dart';

class SetAllPref {



  static loginSuccess({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.loginSuccess,
      dValue: value,
      type: "bool",
    );
  }

  static userId({required String value}) async {
    await SharedPref.setData(
      key: PrefText.userId,
      dValue: value,
      type: "String",
    );
  }

  static userEmail({required String value}) async {
    await SharedPref.setData(
      key: PrefText.email,
      dValue: value,
      type: "String",
    );
  }

  static token({required String value}) async {
    await SharedPref.setData(
      key: PrefText.token,
      dValue: value,
      type: "String",
    );
  }

  static verificationCode({required String value}) async {
    await SharedPref.setData(
      key: PrefText.verificationCode,
      dValue: value,
      type: "String",
    );
  }
  static verificationEmail({required String value}) async {
    await SharedPref.setData(
      key: PrefText.verificationEmail,
      dValue: value,
      type: "String",
    );
  }
}
