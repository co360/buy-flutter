import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/models/label-value.dart';

class StateService extends BaseRestService {
  String _endPoint = 'store-identity-service/state';

  Future<List<LabelValue>> getStateByCountry(String country) async {
    String url = '$_endPoint/dataSourceByCountry?country=$country';
    final response = await dio.get(url);
    List<LabelValue> states = [];
    for (var f in response.data) {
      states.add(LabelValue.fromJson(f));
    }
    return states;
  }
}
