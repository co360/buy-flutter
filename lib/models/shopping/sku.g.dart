// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sku.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sku _$SkuFromJson(Map<String, dynamic> json) {
  return Sku(
    json['isEnabled'] as bool,
    json['skuCode'] as String,
    json['skuUuid'] as String,
    json['productSkuID'] as int,
    (json['variantValues'] as List)
        ?.map((e) =>
            e == null ? null : VariantValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['skuSalesUnit'] == null
        ? null
        : Uom.fromJson(json['skuSalesUnit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SkuToJson(Sku instance) => <String, dynamic>{
      'isEnabled': instance.isEnabled,
      'skuCode': instance.skuCode,
      'skuUuid': instance.skuUuid,
      'productSkuID': instance.productSkuID,
      'variantValues': instance.variantValues,
      'skuSalesUnit': instance.skuSalesUnit,
    };
