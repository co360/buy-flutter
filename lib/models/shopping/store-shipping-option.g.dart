// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store-shipping-option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreShippingOption _$StoreShippingOptionFromJson(Map<String, dynamic> json) {
  return StoreShippingOption(
    shippingAddress: json['shippingAddress'] == null
        ? null
        : Location.fromJson(json['shippingAddress'] as Map<String, dynamic>),
    billingAddress: json['billingAddress'] == null
        ? null
        : Location.fromJson(json['billingAddress'] as Map<String, dynamic>),
    providerName: json['providerName'] as String,
    shippingFee: (json['shippingFee'] as num)?.toDouble(),
    estimatedArrivalDate: json['estimatedArrivalDate'] == null
        ? null
        : LocalDateTime.fromJson(
            json['estimatedArrivalDate'] as Map<String, dynamic>),
    deliveredBy: json['deliveredBy'] as String,
    trackingNo: json['trackingNo'] as String,
    deliveredDate: json['deliveredDate'] == null
        ? null
        : LocalDateTime.fromJson(json['deliveredDate'] as Map<String, dynamic>),
    currencyCode: json['currencyCode'] as String,
    pickupDate: json['pickupDate'] == null
        ? null
        : LocalDateTime.fromJson(json['pickupDate'] as Map<String, dynamic>),
    serviceOrderNo: json['serviceOrderNo'] as String,
    serviceParcelNo: json['serviceParcelNo'] as String,
    serviceStatus: json['serviceStatus'] as String,
    remarks: json['remarks'] as String,
  );
}

Map<String, dynamic> _$StoreShippingOptionToJson(
        StoreShippingOption instance) =>
    <String, dynamic>{
      'shippingAddress': instance.shippingAddress,
      'billingAddress': instance.billingAddress,
      'providerName': instance.providerName,
      'shippingFee': instance.shippingFee,
      'estimatedArrivalDate': instance.estimatedArrivalDate,
      'deliveredBy': instance.deliveredBy,
      'trackingNo': instance.trackingNo,
      'deliveredDate': instance.deliveredDate,
      'currencyCode': instance.currencyCode,
      'pickupDate': instance.pickupDate,
      'serviceOrderNo': instance.serviceOrderNo,
      'serviceParcelNo': instance.serviceParcelNo,
      'serviceStatus': instance.serviceStatus,
      'remarks': instance.remarks,
    };
