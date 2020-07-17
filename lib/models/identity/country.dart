import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  int countryID;
  String code;
  String name;

  Country(this.countryID, this.code, this.name);

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
