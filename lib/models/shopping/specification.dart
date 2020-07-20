import 'package:json_annotation/json_annotation.dart';

part 'specification.g.dart';

@JsonSerializable()
class Specification {
  int id;
  String name;
  String code;
  double value;
  String unit;
  String testMethod;

  Specification(
      this.id, this.name, this.code, this.value, this.unit, this.testMethod);

  factory Specification.fromJson(Map<String, dynamic> json) =>
      _$SpecificationFromJson(json);

  Map<String, dynamic> toJson() => _$SpecificationToJson(this);
}
