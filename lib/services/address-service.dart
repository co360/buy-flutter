import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:country_provider/country_provider.dart';

class AddressService extends BaseRestService {
  String _endPoint = 'store-identity-service';
  CompanyProfile _companyProfile;
  List<Country> _countryLists;

  Future<List<Country>> getCountryList() async {
    _countryLists = await CountryProvider.getAllCountries(
        filter: CountryFilter(isName: true, isAlpha2Code: true));
    return _countryLists;
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

  Future<List<Location>> setAddress(Location data) async {
    String url = '$_endPoint/company-profile/${_companyProfile.id}';

    bool isNew = true;
    bool setDefaultShipping = data.defaultShipping;
    bool setDefaultBilling = data.defaultBilling;

    for (var i = 0; i < _companyProfile.locations.length; i++) {
      if (setDefaultShipping) {
        _companyProfile.locations[i].defaultShipping = false;
      }
      if (setDefaultBilling) {
        _companyProfile.locations[i].defaultBilling = false;
      }
      if (data.id != null && _companyProfile.locations[i].id == data.id) {
        _companyProfile.locations[i] = data;
        for (var f in _countryLists) {
          if (f.alpha2Code == _companyProfile.locations[i].countryCode) {
            _companyProfile.locations[i].countryName = f.name;
            break;
          }
        }
        isNew = false;
      }
    }

    if (isNew) {
      _companyProfile.locations.add(data);
      for (var f in _countryLists) {
        if (f.alpha2Code ==
            _companyProfile
                .locations[_companyProfile.locations.length - 1].countryCode) {
          _companyProfile.locations[_companyProfile.locations.length - 1]
              .countryName = f.name;
          break;
        }
      }
    }

    final response = await dio.put(url, data: _companyProfile.toJson());

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

  Future<List<Location>> deleteAddress(Location data) async {
    String url = '$_endPoint/company-profile/${_companyProfile.id}';

    List<Location> locs = [];
    for (var i = 0; i < _companyProfile.locations.length; i++) {
      if (_companyProfile.locations[i].id != data.id) {
        locs.add(data);
        break;
      }
    }

    _companyProfile.locations = locs;

    final response = await dio.put(url, data: _companyProfile.toJson());

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
