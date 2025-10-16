import '../../service/apiprovider.dart';
import '../model/flash_product_model.dart';

class FlashSaleRepo {
  static Future getFlashSales({required limit,required offset}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "v1/products/flash-sale?limit=${limit}&offset=${offset}",
    );
    return FlashProductResModel.fromJson(jsonData);
  }
}