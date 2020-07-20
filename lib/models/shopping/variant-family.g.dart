// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant-family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantFamily _$VariantFamilyFromJson(Map<String, dynamic> json) {
  return VariantFamily(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    (json['variantTypes'] as List)
        ?.map((e) =>
            e == null ? null : VariantType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VariantFamilyToJson(VariantFamily instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'variantTypes': instance.variantTypes,
    };
