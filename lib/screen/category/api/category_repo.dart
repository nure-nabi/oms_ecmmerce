import 'package:oms_ecommerce/screen/category/model/category_model.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../service/apiprovider.dart';
import '../model/category_product_model.dart';
import '../model/category_top_model.dart';


class CategoryRepo{
  static Future getCategoryHome() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/categories",
    );
    CustomLog.successLog(value: "RESPONSE categories => $jsonData");
    return CategoryResModel.fromJson(jsonData);
  }

  static Future getCategoryTopHome() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/categories/top-categories",
    );
    CustomLog.successLog(value: "RESPONSE Top categories => $jsonData");
    return CategoryTopResponse.fromJson(jsonData);
  }
  // static Future getCategoryProduct({required categoryId}) async {
  //   var jsonData = await APIProvider.getAPI(
  //     endPoint: "v1/products/category/$categoryId",
  //   );
  //   CustomLog.successLog(value: "RESPONSE  categories product => $jsonData");
  //   return CategoryProductResModel.fromJson(jsonData);
  // }

  static Future getCategoryProduct({required categoryId,required limit,required offset}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/category/$categoryId&limit=$limit&offset=$offset",
    );
    //https://gargdental.omsok.com/api/v1/products/category/%7BcategoryId%7D
    CustomLog.successLog(value: "RESPONSE category Data => $jsonData");
    return CategoryProductResModel.fromJson(jsonData);
  }
}