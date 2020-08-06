import 'package:flutter/material.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/models/label-value.dart';

class StateService extends BaseRestService {
  String _endPoint = 'store-identity-service/state';
  List<LabelValue> states = [];

  Future<List<LabelValue>> getStateByCountry(String country) async {
    String url = '$_endPoint/dataSourceByCountry?country=$country';
    final response = await dio.get(url);
    states = [];
    for (var f in response.data) {
      states.add(LabelValue.fromJson(f));
    }
    return states;
  }

  Future<List<LabelValue>> filterStateByName(
      BuildContext context, String filter, String country) async {
    RegExp exp = new RegExp(
      "$filter",
      caseSensitive: false,
    );
    List<LabelValue> matchedItems = [];
    for (var f in states) {
      if (exp.hasMatch(f.label)) {
        matchedItems.add(f);
      }
    }
    return matchedItems;
  }
}
