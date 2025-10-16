import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';

import '../../constant/api_const.dart';
import '../../utils/custom_log.dart';


class APIProvider {
  static Future<Map<String, dynamic>> _handleError(dynamic e) {
    if (e is SocketException) {
      return Future.value(ConstantAPIText.errorNetworkMap);
    } else {
      return Future.value(ConstantAPIText.errorMap);
    }
  }

  static Future<Map<String, dynamic>> _makeRequest({
    required String endPoint,
    required String method,
    dynamic body,
  }) async {
   //String api = "http://192.168.1.64:8000/api/" + endPoint;
    String api = "https://gargdental.omsok.com/api/" + endPoint;
    //final String api = await GetAllPref.apiUrl() + endPoint;
      final headers = {
     // 'Content-Type': 'application/json'
      'Authorization': 'Bearer ${await GetAllPref.token()}'
      };

      //profile_photo_path
    // If body contains a document path, convert it to FormData
    if (body is Map<String, dynamic> && body['document'] != null) {
      // Create FormData
      var formData = FormData.fromMap({
        ...body, // Add all other fields
        'document': await MultipartFile.fromFile(
          body['document'], // Path to the image file
          filename: body['document'].split('/').last, // Optional: set filename
        ),
      });
      body = formData;
      // Add content-type for multipart form data
      headers['Content-Type'] = 'multipart/form-data';
    }

    // If body contains a profile_photo_path path, convert it to FormData
    if (body is Map<String, dynamic> && body['profile_photo_path'] != null) {
      // Create FormData
      var formData = FormData.fromMap({
        ...body, // Add all other fields
        'profile_photo_path': await MultipartFile.fromFile(
          body['profile_photo_path'], // Path to the image file
          filename: body['profile_photo_path'].split('/').last, // Optional: set filename
        ),
      });
      body = formData;
      // Add content-type for multipart form data
      headers['Content-Type'] = 'multipart/form-data';
    }

   // Fluttertoast.showToast(msg: "body['document']");
    try {
      final Response response = await Dio().request(
        api.trim(),
        data: body,
        options: Options(headers: headers, method: method),
      );

      _logRequest(method, api, headers, body, response.data);

      return response.data;
    } on DioException catch (e) {
      _logRequest(method, api, headers, body, e);
      return _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> getAPI({required String endPoint}) async {
    return _makeRequest(endPoint: endPoint, method: 'GET');
  }

  static Future<Map<String, dynamic>> getPostAPI({required String endPoint}) async {
    return _makeRequest(endPoint: endPoint, method: 'Post');
  }

  static Future<Map<String, dynamic>> postAPI2({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    return _makeRequest(endPoint: endPoint, method: 'POST', body: body);
  }

  static Future<Map<String, dynamic>> postAPI({
    required String endPoint,
    required String body,
  }) async {
    return _makeRequest(endPoint: endPoint, method: 'POST', body: body);
  }

  static Future<Map<String, dynamic>> postSingleAPI({
    required String endPoint,
    required String method,
  }) async {
    return _makeRequest(endPoint: endPoint, method: method);
  }

  static Future<Map<String, dynamic>> deleteAPI({
    required String endPoint,
    required String body,
  }) async {
    return _makeRequest(endPoint: endPoint, method: 'DELETE', body: body);
  }

  static void _logRequest(
      String method,
      String api,
      Map<String, String> headers,
      dynamic body,
      dynamic response,
      ) {
    if(kDebugMode){
      CustomLog.actionLog(value: "\n");
      CustomLog.errorLog(value: "METHOD   : [$method]");
      CustomLog.warningLog(value: "API      : [$api]");
      CustomLog.warningLog(value: "BODY     : $body");
      CustomLog.actionLog(value: "HEADER   : $headers");
      CustomLog.successLog(value: "RESPONSE : $response");
      CustomLog.actionLog(value: "\n");
    }

  }
}

