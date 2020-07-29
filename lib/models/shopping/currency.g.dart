// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    currencyID: json['currencyID'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    shortName: json['shortName'] as String,
    suffix: json['suffix'] as String,
    prefix: json['prefix'] as String,
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'currencyID': instance.currencyID,
      'code': instance.code,
      'name': instance.name,
      'shortName': instance.shortName,
      'suffix': instance.suffix,
      'prefix': instance.prefix,
    };
