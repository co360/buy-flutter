// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minimum-order-quantity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinimumOrderQuantity _$MinimumOrderQuantityFromJson(Map<String, dynamic> json) {
  return MinimumOrderQuantity(
    minOrderQtyID: json['minOrderQtyID'] as int,
    productSku: json['productSku'] == null
        ? null
        : ProductSku.fromJson(json['productSku'] as Map<String, dynamic>),
    minQuantity: (json['minQuantity'] as num)?.toDouble(),
    uom: json['uom'] == null
        ? null
        : Uom.fromJson(json['uom'] as Map<String, dynamic>),
    effectiveDate: json['effectiveDate'] == null
        ? null
        : LocalDateTime.fromJson(json['effectiveDate'] as Map<String, dynamic>),
    minQuantityDesc: json['minQuantityDesc'] as String,
  );
}

Map<String, dynamic> _$MinimumOrderQuantityToJson(
        MinimumOrderQuantity instance) =>
    <String, dynamic>{
      'minOrderQtyID': instance.minOrderQtyID,
      'productSku': instance.productSku,
      'minQuantity': instance.minQuantity,
      'uom': instance.uom,
      'effectiveDate': instance.effectiveDate,
      'minQuantityDesc': instance.minQuantityDesc,
    };
