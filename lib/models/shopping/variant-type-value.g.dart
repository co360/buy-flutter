// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant-type-value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantTypeValue _$VariantTypeValueFromJson(Map<String, dynamic> json) {
  return VariantTypeValue(
    json['id'] as int,
    json['value'] as String,
    json['name'] as String,
    json['sortOrder'] as int,
  );
}

Map<String, dynamic> _$VariantTypeValueToJson(VariantTypeValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'name': instance.name,
      'sortOrder': instance.sortOrder,
    };
