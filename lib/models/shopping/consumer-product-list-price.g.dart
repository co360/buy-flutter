// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumer-product-list-price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsumerProductListPrice _$ConsumerProductListPriceFromJson(
    Map<String, dynamic> json) {
  return ConsumerProductListPrice(
    consumerProductListPriceID: json['consumerProductListPriceID'] as int,
    price: (json['price'] as num)?.toDouble(),
    effectiveDate: json['effectiveDate'] == null
        ? null
        : LocalDateTime.fromJson(json['effectiveDate'] as Map<String, dynamic>),
    productSku: json['productSku'] == null
        ? null
        : ProductSku.fromJson(json['productSku'] as Map<String, dynamic>),
    countryCode: json['countryCode'] as String,
    currency: json['currency'] == null
        ? null
        : Currency.fromJson(json['currency'] as Map<String, dynamic>),
    uom: json['uom'] == null
        ? null
        : Uom.fromJson(json['uom'] as Map<String, dynamic>),
    priceDesc: json['priceDesc'] as String,
  );
}

Map<String, dynamic> _$ConsumerProductListPriceToJson(
        ConsumerProductListPrice instance) =>
    <String, dynamic>{
      'consumerProductListPriceID': instance.consumerProductListPriceID,
      'price': instance.price,
      'effectiveDate': instance.effectiveDate,
      'productSku': instance.productSku,
      'countryCode': instance.countryCode,
      'currency': instance.currency,
      'uom': instance.uom,
      'priceDesc': instance.priceDesc,
    };
