import 'package:json_annotation/json_annotation.dart';

part 'uom.g.dart';

@JsonSerializable()
class Uom {
  int uomID;
  String code;
  String name;
  String shortName;

  Uom(this.uomID, this.code, this.name, this.shortName);

  factory Uom.fromJson(Map<String, dynamic> json) => _$UomFromJson(json);

  Map<String, dynamic> toJson() => _$UomToJson(this);
}
