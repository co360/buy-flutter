// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter-type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterMeta _$FilterMetaFromJson(Map<String, dynamic> json) {
  return FilterMeta(
    json['name'] as String,
    json['code'] as String,
    json['metaType'] as String,
    (json['filterValues'] as List)
        ?.map((e) =>
            e == null ? null : FilterValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FilterMetaToJson(FilterMeta instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'metaType': instance.metaType,
      'filterValues': instance.filterValues,
    };

FilterValue _$FilterValueFromJson(Map<String, dynamic> json) {
  return FilterValue(
    json['name'] as String,
    json['code'] as String,
    json['count'] as int,
  );
}

Map<String, dynamic> _$FilterValueToJson(FilterValue instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'count': instance.count,
    };
