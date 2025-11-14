import 'dart:convert';

import '../../../utils/custom_log.dart';

import '../../service/apiprovider.dart';
import '../model/search_product_model.dart';

class SearchProductRepo {
  static Future getSearchProduct({
    required productName,
    required limit,
    required offset,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "v1/products/search?name=$productName&limit=$limit&offset=$offset",
    );
    CustomLog.successLog(value: "RESPONSE Products Search info => $jsonData");
    return SearchProductResp.fromJson(jsonData);
  }
}
