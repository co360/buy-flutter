import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:storeFlutter/datasource/data-source.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/state-service.dart';

class StateDataSource extends DataSource {
  StateService _stateService = GetIt.I<StateService>();
  List<LabelValue> datas = [];
  String cachedParam = '';

  @override
  Future<List<LabelValue>> prepareDataSource(BuildContext context,
      {dynamic param}) async {
    if (datas == null || datas.length == 0 || param != cachedParam) {
      cachedParam = param;
      datas = await _stateService.getStateByCountry(param);
    }
    return datas;
  }

  @override
  String get translateKeyPrefix => "";

  @override
  bool get needTranslate => false;
}
