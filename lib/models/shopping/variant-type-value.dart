import 'package:json_annotation/json_annotation.dart';

part 'variant-type-value.g.dart';

@JsonSerializable()
class VariantTypeValue {
  int id;
  String value;
  String name;

  int sortOrder;

  VariantTypeValue(this.id, this.value, this.name, this.sortOrder);

  factory VariantTypeValue.fromJson(Map<String, dynamic> json) =>
      _$VariantTypeValueFromJson(json);

  Map<String, dynamic> toJson() => _$VariantTypeValueToJson(this);
}
