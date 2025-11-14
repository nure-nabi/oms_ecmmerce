
import 'package:oms_ecommerce/screen/service/apiprovider.dart';

import '../../../utils/custom_log.dart';
import '../../address/model/provience_model.dart';
import '../model/top_category_product_model.dart';


class TopCategoryProductRepo{
  static Future getAllTopCategory({required categoryId,required limit,required offset}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/category-wise-products?limit=$limit&offset=$offset&category_id=$categoryId",
    );
    CustomLog.successLog(value: "RESPONSE brand Data => $jsonData");
    return TopCategoryProductResModel.fromJson(jsonData);
  }
  //https://gargdental.omsok.com/api/v1/products/category-wise-products?category_id=69&limit=10&offset=0
}

//https://gargdental.omsok.com/api/v1/brands/top-brands