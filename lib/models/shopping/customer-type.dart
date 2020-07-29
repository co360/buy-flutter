import 'package:json_annotation/json_annotation.dart';

part 'customer-type.g.dart';

@JsonSerializable()
class CustomerType {
  int customerTypeID;
  String name;
  String code;
  String status;

  CustomerType({this.customerTypeID, this.name, this.code, this.status});

  factory CustomerType.fromJson(Map<String, dynamic> json) =>
      _$CustomerTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerTypeToJson(this);
}
