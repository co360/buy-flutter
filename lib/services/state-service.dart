import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/datasource/state-data-source.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/models/label-value.dart';

class StateService extends BaseRestService {
  String _endPoint = 'store-identity-service/state';
  StateDataSource _stateDataSource = GetIt.I<StateDataSource>();

  Future<List<LabelValue>> getStateByCountry(String country) async {
    String url = '$_endPoint/dataSourceByCountry?country=$country';
    final response = await dio.get(url);
    List<LabelValue> states = [];
    for (var f in response.data) {
      states.add(LabelValue.fromJson(f));
    }
    return states;
  }

  Future<List<LabelValue>> filterStateByName(
      BuildContext context, String filter, String country) async {
    List<LabelValue> states =
        await _stateDataSource.getDataSource(context, param: country);
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
