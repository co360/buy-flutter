import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/models/label-value.dart';

class CityService extends BaseRestService {
  String _endPoint = 'store-identity-service/city';

  Future<List<LabelValue>> getCityByState(String country) async {
    String url = '$_endPoint/dataSourceByState?state=$country';
    final response = await dio.get(url);
    List<LabelValue> citys = [];
    for (var f in response.data) {
      citys.add(LabelValue.fromJson(f));
    }
    return citys;
  }
}
