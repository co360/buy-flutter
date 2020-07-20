import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable()
class Property {
  String name;
  String code;

  Property(this.name, this.code);

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
