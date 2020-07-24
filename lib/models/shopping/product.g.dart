// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    _$enumDecodeNullable(_$ProductTypeEnumMap, json['productType']),
    json['brand'] as String,
    json['model'] as String,
    json['description'] as String,
    json['longDescription'] as String,
    json['keySellingPoint'] as String,
    json['videoUrl'] as String,
    json['dateCreated'] == null
        ? null
        : LocalDate.fromJson(json['dateCreated'] as Map<String, dynamic>),
    json['productApplication'] as String,
    json['howItWork'] as String,
    json['productHandling'] as String,
    (json['keyContactPersons'] as List)?.map((e) => e as int)?.toList(),
    _$enumDecodeNullable(
        _$DeliveryDateOptionEnumMap, json['deliveryDateOption']),
    (json['supplyLocations'] as List)?.map((e) => e as int)?.toList(),
    (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['propertyValues'] as List)
        ?.map((e) => e == null
            ? null
            : PropertyValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['characteristics'] as List)
        ?.map((e) => e == null
            ? null
            : Characteristic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['specificationValues'] as List)
        ?.map((e) => e == null
            ? null
            : SpecificationValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['variantSkus'] as List)
        ?.map((e) => e == null ? null : Sku.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    _$enumDecodeNullable(_$StatusEnumMap, json['status']),
    json['supplierUuid'] as String,
    json['companyId'] as int,
    json['sellerCompany'] == null
        ? null
        : Company.fromJson(json['sellerCompany'] as Map<String, dynamic>),
    json['sellerCompanyProfile'] == null
        ? null
        : CompanyProfile.fromJson(
            json['sellerCompanyProfile'] as Map<String, dynamic>),
    (json['consumerPrice'] as num)?.toDouble(),
    json['consumerPriceUom'] as String,
    json['consumerPriceCurrency'] as String,
    json['skuSize'] as int,
    json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    json['uomCode'] as String,
    json['isContainerize'] as bool,
    json['keywords'] as String,
    json['daysToShip'] as int,
    (json['weight'] as num)?.toDouble(),
    (json['height'] as num)?.toDouble(),
    (json['width'] as num)?.toDouble(),
    (json['length'] as num)?.toDouble(),
    json['warrantyType'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'productType': _$ProductTypeEnumMap[instance.productType],
      'brand': instance.brand,
      'model': instance.model,
      'description': instance.description,
      'longDescription': instance.longDescription,
      'keySellingPoint': instance.keySellingPoint,
      'videoUrl': instance.videoUrl,
      'dateCreated': instance.dateCreated,
      'productApplication': instance.productApplication,
      'howItWork': instance.howItWork,
      'productHandling': instance.productHandling,
      'keyContactPersons': instance.keyContactPersons,
      'deliveryDateOption':
          _$DeliveryDateOptionEnumMap[instance.deliveryDateOption],
      'supplyLocations': instance.supplyLocations,
      'images': instance.images,
      'propertyValues': instance.propertyValues,
      'characteristics': instance.characteristics,
      'specificationValues': instance.specificationValues,
      'variantSkus': instance.variantSkus,
      'status': _$StatusEnumMap[instance.status],
      'supplierUuid': instance.supplierUuid,
      'companyId': instance.companyId,
      'sellerCompany': instance.sellerCompany,
      'sellerCompanyProfile': instance.sellerCompanyProfile,
      'consumerPrice': instance.consumerPrice,
      'consumerPriceUom': instance.consumerPriceUom,
      'consumerPriceCurrency': instance.consumerPriceCurrency,
      'skuSize': instance.skuSize,
      'category': instance.category,
      'uomCode': instance.uomCode,
      'isContainerize': instance.isContainerize,
      'keywords': instance.keywords,
      'daysToShip': instance.daysToShip,
      'weight': instance.weight,
      'height': instance.height,
      'width': instance.width,
      'length': instance.length,
      'warrantyType': instance.warrantyType,
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

const _$ProductTypeEnumMap = {
  ProductType.SKU: 'SKU',
  ProductType.MTO: 'MTO',
};

const _$DeliveryDateOptionEnumMap = {
  DeliveryDateOption.DEFAULT: 'DEFAULT',
  DeliveryDateOption.SPECIFIC: 'SPECIFIC',
  DeliveryDateOption.RANGE: 'RANGE',
  DeliveryDateOption.WEEK: 'WEEK',
  DeliveryDateOption.MONTH: 'MONTH',
};

const _$StatusEnumMap = {
  Status.ACTIVE: 'ACTIVE',
  Status.DRAFT: 'DRAFT',
  Status.INACTIVE: 'INACTIVE',
};
