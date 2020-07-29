// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment-term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTerm _$PaymentTermFromJson(Map<String, dynamic> json) {
  return PaymentTerm(
    paymentTermID: json['paymentTermID'] as int,
    companyId: json['companyId'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    paymentMethod: json['paymentMethod'] == null
        ? null
        : PaymentMethod.fromJson(json['paymentMethod'] as Map<String, dynamic>),
    dueReference: json['dueReference'] as String,
    paymentTermType: json['paymentTermType'] as String,
    usance: json['usance'] as int,
    earlyDiscount: json['earlyDiscount'] as int,
    earlyDiscountPeriod: json['earlyDiscountPeriod'] as String,
    displayName: json['displayName'] as String,
    paymentTermTypeName: json['paymentTermTypeName'] as String,
    proportion: json['proportion'] as int,
    additionalPaymentTerm: json['additionalPaymentTerm'] as bool,
    proportion2: json['proportion2'] as int,
    paymentMethod2: json['paymentMethod2'] == null
        ? null
        : PaymentMethod.fromJson(
            json['paymentMethod2'] as Map<String, dynamic>),
    dueReference2: json['dueReference2'] as String,
    usance2: json['usance2'] as int,
    earlyDiscount2: json['earlyDiscount2'] as int,
    earlyDiscountPeriod2: json['earlyDiscountPeriod2'] as String,
    displayInternalCode: json['displayInternalCode'] as String,
  );
}

Map<String, dynamic> _$PaymentTermToJson(PaymentTerm instance) =>
    <String, dynamic>{
      'paymentTermID': instance.paymentTermID,
      'companyId': instance.companyId,
      'code': instance.code,
      'name': instance.name,
      'paymentMethod': instance.paymentMethod,
      'dueReference': instance.dueReference,
      'paymentTermType': instance.paymentTermType,
      'usance': instance.usance,
      'earlyDiscount': instance.earlyDiscount,
      'earlyDiscountPeriod': instance.earlyDiscountPeriod,
      'displayName': instance.displayName,
      'paymentTermTypeName': instance.paymentTermTypeName,
      'proportion': instance.proportion,
      'additionalPaymentTerm': instance.additionalPaymentTerm,
      'proportion2': instance.proportion2,
      'paymentMethod2': instance.paymentMethod2,
      'dueReference2': instance.dueReference2,
      'usance2': instance.usance2,
      'earlyDiscount2': instance.earlyDiscount2,
      'earlyDiscountPeriod2': instance.earlyDiscountPeriod2,
      'displayInternalCode': instance.displayInternalCode,
    };
