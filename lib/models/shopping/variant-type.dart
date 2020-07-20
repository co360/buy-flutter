import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/input-type.dart';
import 'package:storeFlutter/models/shopping/variant-type-value.dart';

part 'variant-type.g.dart';

@JsonSerializable()
class VariantType {
  int id;
  String name;
  String code;
  InputType inputType;
  Set<VariantTypeValue> variantTypeValues;

  VariantType(
      this.id, this.name, this.code, this.inputType, this.variantTypeValues);

  factory VariantType.fromJson(Map<String, dynamic> json) =>
      _$VariantTypeFromJson(json);

  Map<String, dynamic> toJson() => _$VariantTypeToJson(this);
}
