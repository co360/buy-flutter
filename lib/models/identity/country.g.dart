// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    json['countryID'] as int,
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'countryID': instance.countryID,
      'code': instance.code,
      'name': instance.name,
    };
