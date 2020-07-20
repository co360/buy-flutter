import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/variant-type.dart';

part 'variant-value.g.dart';

@JsonSerializable()
class VariantValue {
  VariantType variantType;
  String value;
  String label;

  VariantValue(this.variantType, this.value, this.label);

  factory VariantValue.fromJson(Map<String, dynamic> json) =>
      _$VariantValueFromJson(json);

  Map<String, dynamic> toJson() => _$VariantValueToJson(this);
}
