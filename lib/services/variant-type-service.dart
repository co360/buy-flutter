import 'package:storeFlutter/models/shopping/variant-type.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class VariantTypeService extends BaseRestService {
  String _endPoint = 'store-ecommerce-service/variant-type';
  String _searchEndPoint = 'store-ecommerce-service/variant-type/search';

  Future<VariantType> get(int id) async {
    var url = '$_endPoint/get/$id';
    final response = await dio.get(url);

    return VariantType.fromJson(response.data["object"]);
  }
}
