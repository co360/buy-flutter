// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uom _$UomFromJson(Map<String, dynamic> json) {
  return Uom(
    json['uomID'] as int,
    json['code'] as String,
    json['name'] as String,
    json['shortName'] as String,
  );
}

Map<String, dynamic> _$UomToJson(Uom instance) => <String, dynamic>{
      'uomID': instance.uomID,
      'code': instance.code,
      'name': instance.name,
      'shortName': instance.shortName,
    };
