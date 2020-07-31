import 'package:flutter/material.dart';
import 'package:storeFlutter/datasource/data-source.dart';
import 'package:storeFlutter/models/label-value.dart';

class AnnualRevenueDataSource extends DataSource {
  List<LabelValue> datas = [
    LabelValue(label: 'Below US\$1 Million', value: '0-1M'),
    LabelValue(label: 'US\$1 Million - US\$2.5 Million', value: '1M-2.5M'),
    LabelValue(label: 'US\$2.5 Million - US\$5 Million', value: '2.5M-5M'),
    LabelValue(label: 'US\$5 Million - US\$10 Million', value: '5M-10M'),
    LabelValue(label: 'US\$10 Million - US\$50 Million', value: '10M-50M'),
    LabelValue(label: 'US\$50 Million - US\$100 Million', value: '50M-100M'),
    LabelValue(label: 'Above US\$100 Million', value: '100M+'),
  ];

  @override
  Future<List<LabelValue>> prepareDataSource(BuildContext context,
      {dynamic param}) async {
    return datas;
  }

  @override
  String get translateKeyPrefix => "dataSource.annualRevenue.";
}
