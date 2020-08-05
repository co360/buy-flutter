import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/models/label-value.dart';

abstract class DataSource {
  Future<List<LabelValue>> getDataSource(BuildContext context,
      {dynamic param}) async {
    List<LabelValue> lvs = await prepareDataSource(context, param: param);

    if (needTranslate) {
      lvs = lvs.map((e) {
        LabelValue translated = LabelValue.fromJson(e.toJson());
        translated.label = translate(context, translated);
        return translated;
      }).toList();
    }

    return lvs;
  }

  @protected
  Future<List<LabelValue>> prepareDataSource(BuildContext context,
      {dynamic param});

  @protected
  String translate(BuildContext context, LabelValue labelValue) {
    final key = translateKeyPrefix + labelValue.value;
    return FlutterI18n.translate(context, key);
  }

  @protected
  bool get needTranslate => true;

  @protected
  String get translateKeyPrefix => "dataSource.general.";
}
