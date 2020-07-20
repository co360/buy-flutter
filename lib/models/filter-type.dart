import 'package:json_annotation/json_annotation.dart';

part 'filter-type.g.dart';

@JsonSerializable()
class FilterMeta {
  String name;
  String code;
  String metaType;
  List<FilterValue> filterValues;

  FilterMeta(this.name, this.code, this.metaType, this.filterValues);

  factory FilterMeta.fromJson(Map<String, dynamic> json) =>
      _$FilterMetaFromJson(json);

  Map<String, dynamic> toJson() => _$FilterMetaToJson(this);
}

@JsonSerializable()
class FilterValue {
  String name;
  String code;
  int count;

  FilterValue(this.name, this.code, this.count);

  factory FilterValue.fromJson(Map<String, dynamic> json) =>
      _$FilterValueFromJson(json);

  Map<String, dynamic> toJson() => _$FilterValueToJson(this);
}
