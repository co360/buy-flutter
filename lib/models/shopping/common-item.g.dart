// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common-item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonItem _$CommonItemFromJson(Map<String, dynamic> json) {
  return CommonItem(
    itemNumber: json['itemNumber'] as String,
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    sku: json['sku'] == null
        ? null
        : Sku.fromJson(json['sku'] as Map<String, dynamic>),
    characteristicValues: (json['characteristicValues'] as List)
        ?.map((e) => e == null
            ? null
            : CharacteristicValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    quantity: (json['quantity'] as num)?.toDouble(),
    invoicePrice: (json['invoicePrice'] as num)?.toDouble(),
    currencyCode: json['currencyCode'] as String,
    uomCode: json['uomCode'] as String,
    incotermCode: json['incotermCode'] as String,
    tradeType: json['tradeType'] as String,
    deliveryMode: json['deliveryMode'] as String,
    shippingConditionCode: json['shippingConditionCode'] as String,
    shippingConditionCode2: json['shippingConditionCode2'] as String,
    shortTermQuantity: (json['shortTermQuantity'] as num)?.toDouble(),
    containerCapacity: (json['containerCapacity'] as num)?.toDouble(),
    priceType: json['priceType'] as String,
    pricingPower: (json['pricingPower'] as num)?.toDouble(),
    containerCapacityFactor:
        (json['containerCapacityFactor'] as num)?.toDouble(),
    promoType: json['promoType'] as String,
    discountPercentage: (json['discountPercentage'] as num)?.toDouble(),
    originalInvoicePrice: (json['originalInvoicePrice'] as num)?.toDouble(),
    maxQuantity: (json['maxQuantity'] as num)?.toDouble(),
    itemType: json['itemType'] as String,
    promoItemNumberRef: json['promoItemNumberRef'] as String,
    stdFreeGoodPct: (json['stdFreeGoodPct'] as num)?.toDouble(),
    stdFreeGoodItemNumberRef: json['stdFreeGoodItemNumberRef'] as String,
    rebateTier: (json['rebateTier'] as num)?.toDouble(),
    rebateAmount: (json['rebateAmount'] as num)?.toDouble(),
    rebateUomCode: json['rebateUomCode'] as String,
    rebateCurrencyCode: json['rebateCurrencyCode'] as String,
    tolerance: (json['tolerance'] as num)?.toDouble(),
    entitleDiscount: json['entitleDiscount'] as bool,
    priceRequestComplete: json['priceRequestComplete'] as bool,
    pricingFormula: json['pricingFormula'] as String,
    pricingAlpha: (json['pricingAlpha'] as num)?.toDouble(),
    isChecked: json['isChecked'] as bool,
    stockRemaining: (json['stockRemaining'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CommonItemToJson(CommonItem instance) =>
    <String, dynamic>{
      'itemNumber': instance.itemNumber,
      'product': instance.product,
      'sku': instance.sku,
      'characteristicValues': instance.characteristicValues,
      'quantity': instance.quantity,
      'invoicePrice': instance.invoicePrice,
      'currencyCode': instance.currencyCode,
      'uomCode': instance.uomCode,
      'incotermCode': instance.incotermCode,
      'tradeType': instance.tradeType,
      'deliveryMode': instance.deliveryMode,
      'shippingConditionCode': instance.shippingConditionCode,
      'shippingConditionCode2': instance.shippingConditionCode2,
      'shortTermQuantity': instance.shortTermQuantity,
      'containerCapacity': instance.containerCapacity,
      'priceType': instance.priceType,
      'pricingPower': instance.pricingPower,
      'containerCapacityFactor': instance.containerCapacityFactor,
      'promoType': instance.promoType,
      'discountPercentage': instance.discountPercentage,
      'originalInvoicePrice': instance.originalInvoicePrice,
      'maxQuantity': instance.maxQuantity,
      'itemType': instance.itemType,
      'promoItemNumberRef': instance.promoItemNumberRef,
      'stdFreeGoodPct': instance.stdFreeGoodPct,
      'stdFreeGoodItemNumberRef': instance.stdFreeGoodItemNumberRef,
      'rebateTier': instance.rebateTier,
      'rebateAmount': instance.rebateAmount,
      'rebateUomCode': instance.rebateUomCode,
      'rebateCurrencyCode': instance.rebateCurrencyCode,
      'tolerance': instance.tolerance,
      'entitleDiscount': instance.entitleDiscount,
      'priceRequestComplete': instance.priceRequestComplete,
      'pricingFormula': instance.pricingFormula,
      'pricingAlpha': instance.pricingAlpha,
      'isChecked': instance.isChecked,
      'stockRemaining': instance.stockRemaining,
    };
