// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['id'] as int,
    json['code'] as String,
    json['name'] as String,
    json['variantFamily'] == null
        ? null
        : VariantFamily.fromJson(json['variantFamily'] as Map<String, dynamic>),
    json['parentCategory'] == null
        ? null
        : Category.fromJson(json['parentCategory'] as Map<String, dynamic>),
    (json['properties'] as List)
        ?.map((e) =>
            e == null ? null : Property.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['characteristics'] as List)
        ?.map((e) => e == null
            ? null
            : Characteristic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'variantFamily': instance.variantFamily,
      'parentCategory': instance.parentCategory,
      'properties': instance.properties,
      'characteristics': instance.characteristics,
      'image': instance.image,
    };
