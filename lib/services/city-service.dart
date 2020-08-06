import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/datasource/city-data-source.dart';
import 'package:storeFlutter/datasource/country-data-source.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/models/label-value.dart';

class CityService extends BaseRestService {
  String _endPoint = 'store-identity-service/city';
  CityDataSource _cityDataSource = GetIt.I<CityDataSource>();

  Future<List<LabelValue>> getCityByState(String country) async {
    String url = '$_endPoint/dataSourceByState?state=$country';
    final response = await dio.get(url);
    List<LabelValue> citys = [];
    for (var f in response.data) {
      citys.add(LabelValue.fromJson(f));
    }
    return citys;
  }

  Future<List<LabelValue>> filterCityByName(
      BuildContext context, String filter, String state) async {
    List<LabelValue> cities =
        await _cityDataSource.getDataSource(context, param: state);
    RegExp exp = new RegExp(
      "$filter",
      caseSensitive: false,
    );
    List<LabelValue> matchedItems = [];
    for (var f in cities) {
      if (exp.hasMatch(f.label)) {
        matchedItems.add(f);
      }
    }
    return matchedItems;
  }
}
