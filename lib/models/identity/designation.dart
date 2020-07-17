import 'package:json_annotation/json_annotation.dart';

part 'designation.g.dart';

@JsonSerializable()
class Designation {
  int id;
  String name;
  String description;

  Designation(this.id, this.name, this.description);

  factory Designation.fromJson(Map<String, dynamic> json) =>
      _$DesignationFromJson(json);

  Map<String, dynamic> toJson() => _$DesignationToJson(this);
}
