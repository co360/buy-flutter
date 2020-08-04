import 'package:storeFlutter/models/shopping/consumer-product-list-price.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ConsumerProductListPriceService extends BaseRestService {
  String _endPoint = 'store-ecommerce-service/consumerProductListPrice';

  Future<ConsumerProductListPrice> getPrice(
      int productSkuId, int sellerCompanyId, String countryCode) async {
    var item =
        'productSkuID=$productSkuId&countryCode=$countryCode&queryDate=&sellerCompanyID=$sellerCompanyId';
    var url = '$_endPoint/getPrice?$item';
    final response = await dio.get(url);

    return ConsumerProductListPrice.fromJson(response.data['object']);
  }
}
