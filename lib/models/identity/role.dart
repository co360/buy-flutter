import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/identity/lst-function.dart';
import 'package:storeFlutter/models/local-date.dart';

part 'role.g.dart';

@JsonSerializable()
class Role {
  int id;
  String name;
  String description;
  LocalDate accessFromDate;
  LocalDate accessToDate;
  String accessFromTime;
  String accessToTime;
  List<LstFunction> lstFunction;

  Role(
    this.id,
    this.name,
    this.description,
    this.accessFromDate,
    this.accessToDate,
    this.accessFromTime,
    this.accessToTime,
    this.lstFunction,
  );

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
