// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange-rate-type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateType _$ExchangeRateTypeFromJson(Map<String, dynamic> json) {
  return ExchangeRateType(
    exchangeRateTypeID: json['exchangeRateTypeID'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    companyId: json['companyId'] as int,
  );
}

Map<String, dynamic> _$ExchangeRateTypeToJson(ExchangeRateType instance) =>
    <String, dynamic>{
      'exchangeRateTypeID': instance.exchangeRateTypeID,
      'code': instance.code,
      'name': instance.name,
      'companyId': instance.companyId,
    };
