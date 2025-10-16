
import 'package:oms_ecommerce/screen/service/apiprovider.dart';

import '../../../utils/custom_log.dart';
import '../../address/model/provience_model.dart';
import '../model/brand_model.dart';
import '../model/brand_product_model.dart';

class BrandRepo{


  static Future getBrand() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/brands/top-brands",
    );
    // CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return BrandResponse.fromJson(jsonData);
  }

  static Future getAllBrandProduct({required brandId,required limit,required offset}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/brand-wise-products?limit=$limit&offset=$offset&brand_id=$brandId",
    );
    CustomLog.successLog(value: "RESPONSE brand Data => $jsonData");
    return BrandProductResModel.fromJson(jsonData);
  }

}

//https://gargdental.omsok.com/api/v1/brands/top-brands