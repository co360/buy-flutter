// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characteristic-value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacteristicValue _$CharacteristicValueFromJson(Map<String, dynamic> json) {
  return CharacteristicValue(
    characteristic: json['characteristic'] == null
        ? null
        : Characteristic.fromJson(
            json['characteristic'] as Map<String, dynamic>),
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$CharacteristicValueToJson(
        CharacteristicValue instance) =>
    <String, dynamic>{
      'characteristic': instance.characteristic,
      'value': instance.value,
    };
