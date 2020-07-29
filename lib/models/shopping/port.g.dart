// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'port.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Port _$PortFromJson(Map<String, dynamic> json) {
  return Port(
    portID: json['portID'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    shortName: json['shortName'] as String,
  );
}

Map<String, dynamic> _$PortToJson(Port instance) => <String, dynamic>{
      'portID': instance.portID,
      'code': instance.code,
      'name': instance.name,
      'shortName': instance.shortName,
    };
