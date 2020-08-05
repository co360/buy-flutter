import 'package:storeFlutter/models/shopping/product-stock-quantity.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ProductStockQuantityService extends BaseRestService {
  String _endPoint = 'store-ecommerce-service/productStockQuantity';

  Future<ProductStockQuantity> getStock(
      int productSkuId, int sellerCompanyId, String countryCode) async {
    var item =
        'productSkuID=$productSkuId&countryCode=$countryCode&sellerCompanyID=$sellerCompanyId';
    var url = '$_endPoint/getStock?$item';
    final response = await dio.get(url);

    return getResponseObject<ProductStockQuantity>(
        response.data, (json) => ProductStockQuantity.fromJson(json));
  }
}
