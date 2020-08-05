// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easy-parcel-param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EasyParcelParam _$EasyParcelParamFromJson(Map<String, dynamic> json) {
  return EasyParcelParam(
    senderPostcode: json['senderPostcode'] as String,
    senderState: json['senderState'] as String,
    senderCountry: json['senderCountry'] as String,
    receiverPostcode: json['receiverPostcode'] as String,
    receiverState: json['receiverState'] as String,
    receiverCountry: json['receiverCountry'] as String,
    weight: (json['weight'] as num)?.toDouble(),
    length: (json['length'] as num)?.toDouble(),
    width: (json['width'] as num)?.toDouble(),
    height: (json['height'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$EasyParcelParamToJson(EasyParcelParam instance) =>
    <String, dynamic>{
      'senderPostcode': instance.senderPostcode,
      'senderState': instance.senderState,
      'senderCountry': instance.senderCountry,
      'receiverPostcode': instance.receiverPostcode,
      'receiverState': instance.receiverState,
      'receiverCountry': instance.receiverCountry,
      'weight': instance.weight,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
    };
