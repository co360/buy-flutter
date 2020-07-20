// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specification _$SpecificationFromJson(Map<String, dynamic> json) {
  return Specification(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    (json['value'] as num)?.toDouble(),
    json['unit'] as String,
    json['testMethod'] as String,
  );
}

Map<String, dynamic> _$SpecificationToJson(Specification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'value': instance.value,
      'unit': instance.unit,
      'testMethod': instance.testMethod,
    };
