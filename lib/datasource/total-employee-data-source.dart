import 'package:flutter/material.dart';
import 'package:storeFlutter/datasource/data-source.dart';
import 'package:storeFlutter/models/label-value.dart';

class TotalEmployeeDataSource extends DataSource {
  List<LabelValue> datas = [
    LabelValue(label: '1-10 employees', value: '1-10'),
    LabelValue(label: '11-50 employees', value: '11-50'),
    LabelValue(label: '51-200 employees', value: '51-200'),
    LabelValue(label: '201-500 employees', value: '201-500'),
    LabelValue(label: '501-1000 employees', value: '501-1000'),
    LabelValue(label: '1001-5000 employees', value: '1001-5000'),
    LabelValue(label: '5001-10,000 employees', value: '5001-10,000'),
    LabelValue(label: '10,001+ employees', value: '10,001+'),
  ];

  @override
  Future<List<LabelValue>> prepareDataSource(BuildContext context,
      {dynamic param}) async {
    return datas;
  }

  @override
  String get translateKeyPrefix => "dataSource.totalEmployee.";
}
