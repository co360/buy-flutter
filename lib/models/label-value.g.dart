// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label-value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelValue _$LabelValueFromJson(Map<String, dynamic> json) {
  return LabelValue(
    json['label'] as String,
    json['label2'] as String,
    json['label3'] as String,
    json['label4'] as String,
    json['value'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$LabelValueToJson(LabelValue instance) =>
    <String, dynamic>{
      'label': instance.label,
      'label2': instance.label2,
      'label3': instance.label3,
      'label4': instance.label4,
      'value': instance.value,
      'code': instance.code,
    };
