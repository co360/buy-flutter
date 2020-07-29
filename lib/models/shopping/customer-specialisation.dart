import 'package:json_annotation/json_annotation.dart';

part 'customer-specialisation.g.dart';

@JsonSerializable()
class CustomerSpecialisation {
  int customerSpecialisationID;
  String name;
  String code;
  String status;

  CustomerSpecialisation(
      {this.customerSpecialisationID, this.name, this.code, this.status});

  factory CustomerSpecialisation.fromJson(Map<String, dynamic> json) =>
      _$CustomerSpecialisationFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerSpecialisationToJson(this);
}
