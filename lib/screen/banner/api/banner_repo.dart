import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../service/apiprovider.dart';
import '../model/banner_res_model.dart';

class BannerRepo{
  static Future getBanner() async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/banners",
    );
   // CustomLog.successLog(value: "RESPONSE Save Data => $jsonData");
    return BannerResModel.fromJson(jsonData);
  }
}