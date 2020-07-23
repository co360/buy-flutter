// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date-type.dart';

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

LocalTime _$LocalTimeFromJson(Map<String, dynamic> json) {
  return LocalTime(
    json['hour'] as int,
    json['minute'] as int,
    json['second'] as int,
  );
}

Map<String, dynamic> _$LocalTimeToJson(LocalTime instance) => <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
      'second': instance.second,
    };

LocalDateTime _$LocalDateTimeFromJson(Map<String, dynamic> json) {
  return LocalDateTime(
    json['year'] as int,
    json['month'] as int,
    json['day'] as int,
    json['hour'] as int,
    json['minute'] as int,
    json['second'] as int,
  );
}

Map<String, dynamic> _$LocalDateTimeToJson(LocalDateTime instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'hour': instance.hour,
      'minute': instance.minute,
      'second': instance.second,
    };
