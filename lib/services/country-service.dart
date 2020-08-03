import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/identity/country.dart';

class CountryService extends BaseRestService {
  String _endPoint = 'store-identity-service/country';

  Future<List<LabelValue>> getCountryList() async {
    String url = '$_endPoint/dataSource';
    final response = await dio.get(url);
    List<LabelValue> countries = [];
    for (var f in response.data) {
      countries.add(LabelValue.fromJson(f));
    }
    return countries;
  }

  Future<Country> getCountryByCode(String code) async {
    String url = '$_endPoint/findObjByCode/$code';
    final response = await dio.get(url);
    return Country.fromJson(response.data);
  }

  Future<Country> getCountryById(int id) async {
    String url = '$_endPoint/findObjById/$id';
    final response = await dio.get(url);
    return Country.fromJson(response.data);
  }
}
