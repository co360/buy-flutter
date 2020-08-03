import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:storeFlutter/datasource/data-source.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/country-service.dart';

class CountryDataSource extends DataSource {
  CountryService _countryService = GetIt.I<CountryService>();
  List<LabelValue> datas = [];

  @override
  Future<List<LabelValue>> prepareDataSource(BuildContext context,
      {dynamic param}) async {
    if (datas == null || datas.length == 0) {
      datas = await _countryService.getCountryList();
    }
    return datas;
  }

  @override
  String get translateKeyPrefix => "";

  @override
  bool get needTranslate => false;
}
