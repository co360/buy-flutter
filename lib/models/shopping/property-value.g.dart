// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property-value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyValue _$PropertyValueFromJson(Map<String, dynamic> json) {
  return PropertyValue(
    json['property'] == null
        ? null
        : Property.fromJson(json['property'] as Map<String, dynamic>),
    json['value'] as String,
  );
}

Map<String, dynamic> _$PropertyValueToJson(PropertyValue instance) =>
    <String, dynamic>{
      'property': instance.property,
      'value': instance.value,
    };
