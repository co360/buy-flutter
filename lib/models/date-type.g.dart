// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date-type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalDate _$LocalDateFromJson(Map<String, dynamic> json) {
  return LocalDate(
    year: json['year'] as int,
    month: json['month'] as int,
    day: json['day'] as int,
  );
}

Map<String, dynamic> _$LocalDateToJson(LocalDate instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
    };

LocalTime _$LocalTimeFromJson(Map<String, dynamic> json) {
  return LocalTime(
    hour: json['hour'] as int,
    minute: json['minute'] as int,
    second: json['second'] as int,
  );
}

Map<String, dynamic> _$LocalTimeToJson(LocalTime instance) => <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
      'second': instance.second,
    };

LocalDateTime _$LocalDateTimeFromJson(Map<String, dynamic> json) {
  return LocalDateTime(
    year: json['year'] as int,
    month: json['month'] as int,
    day: json['day'] as int,
    hour: json['hour'] as int,
    minute: json['minute'] as int,
    second: json['second'] as int,
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

LocalDateRange _$LocalDateRangeFromJson(Map<String, dynamic> json) {
  return LocalDateRange(
    from: json['from'] == null
        ? null
        : LocalDate.fromJson(json['from'] as Map<String, dynamic>),
    to: json['to'] == null
        ? null
        : LocalDate.fromJson(json['to'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocalDateRangeToJson(LocalDateRange instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };
