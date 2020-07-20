import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ProductService extends BaseRestService {
  static ProductService _instance;

  ProductService._();

  static ProductService getInstance() {
    if (_instance == null) {
      _instance = ProductService._();
    }

    return _instance;
  }

  Future<List<LabelValue>> keyWordByName(String name) async {
    var url = 'buy-ecommerce-service/product/keywordByName?name=$name';
    return await dio.get<List<dynamic>>(url).then((value) {
      print(value.data);

      return value.data.map((e) => LabelValue.fromJson(e)).toList();
    });
  }
}
