// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant-value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantValue _$VariantValueFromJson(Map<String, dynamic> json) {
  return VariantValue(
    json['variantType'] == null
        ? null
        : VariantType.fromJson(json['variantType'] as Map<String, dynamic>),
    json['value'] as String,
    json['label'] as String,
  );
}

Map<String, dynamic> _$VariantValueToJson(VariantValue instance) =>
    <String, dynamic>{
      'variantType': instance.variantType,
      'value': instance.value,
      'label': instance.label,
    };
