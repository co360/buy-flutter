// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    customerID: json['customerID'] as int,
    companyId: json['companyId'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    shortName: json['shortName'] as String,
    contactPerson: json['contactPerson'] as String,
    contactEmail: json['contactEmail'] as String,
    onboardEmailDate: json['onboardEmailDate'] == null
        ? null
        : LocalDateTime.fromJson(
            json['onboardEmailDate'] as Map<String, dynamic>),
    onboardedDate: json['onboardedDate'] == null
        ? null
        : LocalDateTime.fromJson(json['onboardedDate'] as Map<String, dynamic>),
    onboardStatus:
        _$enumDecodeNullable(_$OnboardStatusEnumMap, json['onboardStatus']),
    customerStatus:
        _$enumDecodeNullable(_$CustomerStatusEnumMap, json['customerStatus']),
    referenceCompanyID: json['referenceCompanyID'] as int,
    industry: json['industry'] == null
        ? null
        : Industry.fromJson(json['industry'] as Map<String, dynamic>),
    incoterm: json['incoterm'] == null
        ? null
        : Incoterm.fromJson(json['incoterm'] as Map<String, dynamic>),
    paymentTerm: json['paymentTerm'] == null
        ? null
        : PaymentTerm.fromJson(json['paymentTerm'] as Map<String, dynamic>),
    paymentMethod: json['paymentMethod'] == null
        ? null
        : PaymentMethod.fromJson(json['paymentMethod'] as Map<String, dynamic>),
    currencyCode: json['currencyCode'] as String,
    currency: json['currency'] == null
        ? null
        : Currency.fromJson(json['currency'] as Map<String, dynamic>),
    exchangeRateType: json['exchangeRateType'] == null
        ? null
        : ExchangeRateType.fromJson(
            json['exchangeRateType'] as Map<String, dynamic>),
    billingAddress: json['billingAddress'] as String,
    billingCountryCode: json['billingCountryCode'] as String,
    billingCountryName: json['billingCountryName'] as String,
    billingPostcode: json['billingPostcode'] as String,
    billingCity: json['billingCity'] as String,
    billingState: json['billingState'] as String,
    tradeType: json['tradeType'] as String,
    deliveryMode: json['deliveryMode'] as String,
    shippingAddress: json['shippingAddress'] as String,
    shippingCountryCode: json['shippingCountryCode'] as String,
    shippingPortCode: json['shippingPortCode'] as String,
    shippingPort: json['shippingPort'] == null
        ? null
        : Port.fromJson(json['shippingPort'] as Map<String, dynamic>),
    shippingPostcode: json['shippingPostcode'] as String,
    shippingCity: json['shippingCity'] as String,
    shippingState: json['shippingState'] as String,
    nearestPortCountry: json['nearestPortCountry'] as String,
    customerType: json['customerType'] == null
        ? null
        : CustomerType.fromJson(json['customerType'] as Map<String, dynamic>),
    customerSpecialisation: json['customerSpecialisation'] == null
        ? null
        : CustomerSpecialisation.fromJson(
            json['customerSpecialisation'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'customerID': instance.customerID,
      'companyId': instance.companyId,
      'name': instance.name,
      'code': instance.code,
      'shortName': instance.shortName,
      'contactPerson': instance.contactPerson,
      'contactEmail': instance.contactEmail,
      'onboardEmailDate': instance.onboardEmailDate,
      'onboardedDate': instance.onboardedDate,
      'onboardStatus': _$OnboardStatusEnumMap[instance.onboardStatus],
      'customerStatus': _$CustomerStatusEnumMap[instance.customerStatus],
      'referenceCompanyID': instance.referenceCompanyID,
      'industry': instance.industry,
      'incoterm': instance.incoterm,
      'paymentTerm': instance.paymentTerm,
      'paymentMethod': instance.paymentMethod,
      'currencyCode': instance.currencyCode,
      'currency': instance.currency,
      'exchangeRateType': instance.exchangeRateType,
      'billingAddress': instance.billingAddress,
      'billingCountryCode': instance.billingCountryCode,
      'billingCountryName': instance.billingCountryName,
      'billingPostcode': instance.billingPostcode,
      'billingCity': instance.billingCity,
      'billingState': instance.billingState,
      'tradeType': instance.tradeType,
      'deliveryMode': instance.deliveryMode,
      'shippingAddress': instance.shippingAddress,
      'shippingCountryCode': instance.shippingCountryCode,
      'shippingPortCode': instance.shippingPortCode,
      'shippingPort': instance.shippingPort,
      'shippingPostcode': instance.shippingPostcode,
      'shippingCity': instance.shippingCity,
      'shippingState': instance.shippingState,
      'nearestPortCountry': instance.nearestPortCountry,
      'customerType': instance.customerType,
      'customerSpecialisation': instance.customerSpecialisation,
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

const _$OnboardStatusEnumMap = {
  OnboardStatus.PENDING: 'PENDING',
  OnboardStatus.ONBOARDED: 'ONBOARDED',
};

const _$CustomerStatusEnumMap = {
  CustomerStatus.ACTIVE: 'ACTIVE',
  CustomerStatus.INACTIVE: 'INACTIVE',
};
