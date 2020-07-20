// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characteristic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Characteristic _$CharacteristicFromJson(Map<String, dynamic> json) {
  return Characteristic(
    json['characteristicID'] as int,
    json['code'] as String,
    json['name'] as String,
    json['prefix'] as String,
    json['postfix'] as String,
    json['min'] as int,
    json['max'] as int,
    json['mandatory'] as String,
    (json['lstItem'] as List)
        ?.map((e) => e == null
            ? null
            : CharacteristicItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    _$enumDecodeNullable(_$CharTypeEnumMap, json['charType']),
  );
}

Map<String, dynamic> _$CharacteristicToJson(Characteristic instance) =>
    <String, dynamic>{
      'characteristicID': instance.characteristicID,
      'code': instance.code,
      'name': instance.name,
      'prefix': instance.prefix,
      'postfix': instance.postfix,
      'min': instance.min,
      'max': instance.max,
      'mandatory': instance.mandatory,
      'lstItem': instance.lstItem,
      'charType': _$CharTypeEnumMap[instance.charType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CharTypeEnumMap = {
  CharType.TEXT: 'TEXT',
  CharType.DATASOURCE: 'DATASOURCE',
  CharType.NUMBER: 'NUMBER',
  CharType.GROUP: 'GROUP',
};
