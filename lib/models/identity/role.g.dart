// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['accessFromDate'] == null
        ? null
        : LocalDate.fromJson(json['accessFromDate'] as Map<String, dynamic>),
    json['accessToDate'] == null
        ? null
        : LocalDate.fromJson(json['accessToDate'] as Map<String, dynamic>),
    json['accessFromTime'] as String,
    json['accessToTime'] as String,
    (json['lstFunction'] as List)
        ?.map((e) =>
            e == null ? null : LstFunction.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'accessFromDate': instance.accessFromDate,
      'accessToDate': instance.accessToDate,
      'accessFromTime': instance.accessFromTime,
      'accessToTime': instance.accessToTime,
      'lstFunction': instance.lstFunction,
    };
