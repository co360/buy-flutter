// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'designation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Designation _$DesignationFromJson(Map<String, dynamic> json) {
  return Designation(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$DesignationToJson(Designation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
