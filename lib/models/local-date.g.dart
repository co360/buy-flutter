// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local-date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalDate _$LocalDateFromJson(Map<String, dynamic> json) {
  return LocalDate(
    json['year'] as int,
    json['month'] as int,
    json['day'] as int,
  );
}

Map<String, dynamic> _$LocalDateToJson(LocalDate instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
    };
