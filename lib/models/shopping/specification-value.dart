import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/specification.dart';

part 'specification-value.g.dart';

@JsonSerializable()
class SpecificationValue {
  Specification specification;
  String value;

  SpecificationValue(this.specification, this.value);

  factory SpecificationValue.fromJson(Map<String, dynamic> json) =>
      _$SpecificationValueFromJson(json);

  Map<String, dynamic> toJson() => _$SpecificationValueToJson(this);
}
