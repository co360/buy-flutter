import 'package:json_annotation/json_annotation.dart';

part 'local-date.g.dart';

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
