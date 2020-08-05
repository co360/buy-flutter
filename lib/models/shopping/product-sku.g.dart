// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product-sku.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSku _$ProductSkuFromJson(Map<String, dynamic> json) {
  return ProductSku(
    productSkuID: json['productSkuID'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    catalogProductID: json['catalogProductID'] as int,
    salesUnit: json['salesUnit'] == null
        ? null
        : Uom.fromJson(json['salesUnit'] as Map<String, dynamic>),
    recordStatus: json['recordStatus'] as String,
  );
}

Map<String, dynamic> _$ProductSkuToJson(ProductSku instance) =>
    <String, dynamic>{
      'productSkuID': instance.productSkuID,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'catalogProductID': instance.catalogProductID,
      'salesUnit': instance.salesUnit,
      'recordStatus': instance.recordStatus,
    };
