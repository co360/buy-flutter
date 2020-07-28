// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Industry _$IndustryFromJson(Map<String, dynamic> json) {
  return Industry(
    industryID: json['industryID'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'industryID': instance.industryID,
      'code': instance.code,
      'name': instance.name,
    };
