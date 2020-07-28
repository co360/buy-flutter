import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:country_provider/country_provider.dart';

class AddressService extends BaseRestService {
  String _endPoint = 'store-identity-service';
  CompanyProfile _companyProfile;

  Future<List<Country>> getCountryList() async {
    List<Country> lists = await CountryProvider.getAllCountries();
    return lists;
  }

  Future<List<LabelValue>> getStateList(String country) async {
    String url = '$_endPoint/state/dataSourceByCountry?country=$country';
    final response = await dio.get(url);
    print(response.data);
    List<LabelValue> lists = [];
    for (var f in response.data) {
      lists.add(LabelValue.fromJson(f));
    }
    return lists;
  }

  Future<List<LabelValue>> getCityList(String state) async {
    String url = '$_endPoint/city/dataSourceByState?state=$state';
    final response = await dio.get(url);
    print(response.data);
    List<LabelValue> lists = [];
    for (var f in response.data) {
      lists.add(LabelValue.fromJson(f));
    }
    return lists;
  }

  Future<List<Location>> setAddress(int id, CompanyProfile data) async {
    String url = '$_endPoint/company-profile/$id';
    final response = await dio.put(url, data: data.toJson());

    print(response.data);

    if (response.data['object'] != null) {
      List<Location> lists = [];
      for (var f in response.data['object']) {
        lists.add(f);
      }
      _companyProfile = CompanyProfile.fromJson(response.data['object']);
      return lists;
    } else {
      return null;
    }
  }

  Future<CompanyProfile> getCompanyProfile() async {
    return _companyProfile;
  }

  Future<Location> getAddressByID(int id) async {
    for (var f in _companyProfile.locations) {
      if (f.id == id) return f;
    }
    return null;
  }

  Future<List<Location>> getAddress(int id) async {
    String url = '$_endPoint/company-profile/find-by-company/$id';
    final response = await dio.get(url);

    print(response.data);

    if (response.data['object'] != null) {
      _companyProfile = CompanyProfile.fromJson(response.data['object']);

      List<Location> lists = [];
      for (var f in _companyProfile.locations) {
        print(f);
        lists.add(f);
      }

      return lists;
    } else {
      return null;
    }
  }
}
