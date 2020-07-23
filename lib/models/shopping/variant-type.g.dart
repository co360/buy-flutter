// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant-type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantType _$VariantTypeFromJson(Map<String, dynamic> json) {
  return VariantType(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    _$enumDecodeNullable(_$InputTypeEnumMap, json['inputType']),
    (json['variantTypeValues'] as List)
        ?.map((e) => e == null
            ? null
            : VariantTypeValue.fromJson(e as Map<String, dynamic>))
        ?.toSet(),
  );
}

Map<String, dynamic> _$VariantTypeToJson(VariantType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'inputType': _$InputTypeEnumMap[instance.inputType],
      'variantTypeValues': instance.variantTypeValues?.toList(),
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

const _$InputTypeEnumMap = {
  InputType.TEXTFIELD: 'TEXTFIELD',
  InputType.DROPDOWN: 'DROPDOWN',
  InputType.DATEFIELD: 'DATEFIELD',
  InputType.DATETIMEFIELD: 'DATETIMEFIELD',
  InputType.NUMBERFIELD: 'NUMBERFIELD',
  InputType.TEXTAREA: 'TEXTAREA',
  InputType.CHECKBOX: 'CHECKBOX',
  InputType.RADIOBUTTON: 'RADIOBUTTON',
  InputType.DATEORRANGEFIELD: 'DATEORRANGEFIELD',
  InputType.PREDEFINEDFIELD: 'PREDEFINEDFIELD',
};
