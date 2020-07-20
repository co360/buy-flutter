// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) {
  return Property(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };
