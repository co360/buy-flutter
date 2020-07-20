// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification-value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificationValue _$SpecificationValueFromJson(Map<String, dynamic> json) {
  return SpecificationValue(
    json['specification'] == null
        ? null
        : Specification.fromJson(json['specification'] as Map<String, dynamic>),
    json['value'] as String,
  );
}

Map<String, dynamic> _$SpecificationValueToJson(SpecificationValue instance) =>
    <String, dynamic>{
      'specification': instance.specification,
      'value': instance.value,
    };
