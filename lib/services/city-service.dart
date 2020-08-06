import 'package:flutter/material.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/models/label-value.dart';

class CityService extends BaseRestService {
  String _endPoint = 'store-identity-service/city';
  List<LabelValue> cities = [];

  Future<List<LabelValue>> getCityByState(String country) async {
    String url = '$_endPoint/dataSourceByState?state=$country';
    final response = await dio.get(url);

    for (var f in response.data) {
      cities.add(LabelValue.fromJson(f));
    }
    return cities;
  }

  Future<List<LabelValue>> filterCityByName(
      BuildContext context, String filter, String state) async {
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
