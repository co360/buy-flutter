import 'package:storeFlutter/models/shopping/minimum-order-quantity.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class MinimumOrderQuantityService extends BaseRestService {
  String _endPoint = 'store-ecommerce-service/minimumOrderQuantity';

  Future<MinimumOrderQuantity> findMinimumOrder(
      int productSkuId, int sellerCompanyId) async {
    var item = 'productSkuID=$productSkuId&sellerCompanyID=$sellerCompanyId';
    var url = '$_endPoint/findMinimumOrder?$item';
    final response = await dio.get(url);

    return getResponseObject<MinimumOrderQuantity>(
        response.data, (json) => MinimumOrderQuantity.fromJson(json));
  }
}
