// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment-method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return PaymentMethod(
    paymentMethodID: json['paymentMethodID'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'paymentMethodID': instance.paymentMethodID,
      'code': instance.code,
      'name': instance.name,
    };
