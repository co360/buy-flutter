import 'package:json_annotation/json_annotation.dart';

part 'date-type.g.dart';

@JsonSerializable()
class LocalDate {
  int year;
  int month;
  int day;

  LocalDate({this.year, this.month, this.day});

  factory LocalDate.fromJson(Map<String, dynamic> json) =>
      _$LocalDateFromJson(json);

  Map<String, dynamic> toJson() => _$LocalDateToJson(this);
}

@JsonSerializable()
class LocalTime {
  int hour;
  int minute;
  int second;

  LocalTime({this.hour, this.minute, this.second});

  factory LocalTime.fromJson(Map<String, dynamic> json) =>
      _$LocalTimeFromJson(json);

  Map<String, dynamic> toJson() => _$LocalTimeToJson(this);
}

@JsonSerializable()
class LocalDateTime {
  int year;
  int month;
  int day;

  int hour;
  int minute;
  int second;

  LocalDateTime(
      {this.year, this.month, this.day, this.hour, this.minute, this.second});

  factory LocalDateTime.fromJson(Map<String, dynamic> json) =>
      _$LocalDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$LocalDateTimeToJson(this);
}

@JsonSerializable()
class LocalDateRange {
  LocalDate from;
  LocalDate to;

  LocalDateRange({this.from, this.to});

  factory LocalDateRange.fromJson(Map<String, dynamic> json) =>
      _$LocalDateRangeFromJson(json);

  Map<String, dynamic> toJson() => _$LocalDateRangeToJson(this);
}
