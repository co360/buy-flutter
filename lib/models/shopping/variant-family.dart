import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/variant-type.dart';

part 'variant-family.g.dart';

@JsonSerializable()
class VariantFamily {
  int id;
  String name;
  String code;
  List<VariantType> variantTypes;

  VariantFamily(this.id, this.name, this.code, this.variantTypes);

  factory VariantFamily.fromJson(Map<String, dynamic> json) =>
      _$VariantFamilyFromJson(json);

  Map<String, dynamic> toJson() => _$VariantFamilyToJson(this);
}
