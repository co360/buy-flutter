// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product-stock-quantity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductStockQuantity _$ProductStockQuantityFromJson(Map<String, dynamic> json) {
  return ProductStockQuantity(
    productStockQuantityID: json['productStockQuantityID'] as int,
    stock: (json['stock'] as num)?.toDouble(),
    productSku: json['productSku'] == null
        ? null
        : ProductSku.fromJson(json['productSku'] as Map<String, dynamic>),
    countryCode: json['countryCode'] as String,
  );
}

Map<String, dynamic> _$ProductStockQuantityToJson(
        ProductStockQuantity instance) =>
    <String, dynamic>{
      'productStockQuantityID': instance.productStockQuantityID,
      'stock': instance.stock,
      'productSku': instance.productSku,
      'countryCode': instance.countryCode,
    };
