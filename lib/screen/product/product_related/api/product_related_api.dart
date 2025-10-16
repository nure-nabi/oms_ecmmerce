

import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../../service/apiprovider.dart';
import '../model/product_related_model.dart';



//192.168.1.64:8000/api/v1/customer/cart/add

class ProductRelatedRepo{
  static Future getProductRelated({required productCode}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/related-products/$productCode",
    );
    CustomLog.successLog(value: "ProductRelatedResModel Data => $jsonData");
    return ProductRelatedResModel.fromJson(jsonData);
  }




}