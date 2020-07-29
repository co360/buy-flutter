// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incoterm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Incoterm _$IncotermFromJson(Map<String, dynamic> json) {
  return Incoterm(
    incotermID: json['incotermID'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$IncotermToJson(Incoterm instance) => <String, dynamic>{
      'incotermID': instance.incotermID,
      'code': instance.code,
      'name': instance.name,
    };
