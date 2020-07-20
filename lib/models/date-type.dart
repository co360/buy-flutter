import 'package:json_annotation/json_annotation.dart';

part 'date-type.g.dart';

@JsonSerializable()
class LocalDate {
  int year;
  int month;
  int day;

  LocalDate(this.year, this.month, this.day);

  factory LocalDate.fromJson(Map<String, dynamic> json) =>
      _$LocalDateFromJson(json);

  Map<String, dynamic> toJson() => _$LocalDateToJson(this);
}

@JsonSerializable()
class LocalTime {
  int hour;
  int minute;
  int second;

  LocalTime(this.hour, this.minute, this.second);

  factory LocalTime.fromJson(Map<String, dynamic> json) =>
      _$LocalTimeFromJson(json);

  Map<String, dynamic> toJson() => _$LocalTimeToJson(this);
}
