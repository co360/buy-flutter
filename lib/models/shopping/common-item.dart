import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/characteristic-value.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/sku.dart';

part 'common-item.g.dart';

@JsonSerializable()
class CommonItem {
  String itemNumber;
  Product product;
  Sku sku;
  List<CharacteristicValue> characteristicValues;
  double quantity;
  double invoicePrice;
  String currencyCode;
  String uomCode;
  String incotermCode;
  String tradeType;
  String deliveryMode;
  String shippingConditionCode;
  String shippingConditionCode2;
//  revisions: SalesQuotationRevise[];
  double shortTermQuantity;
  double containerCapacity;
  String priceType;
  double pricingPower;

  //transient
  double containerCapacityFactor;

  // pharma
  String promoType;
  double discountPercentage;
  double originalInvoicePrice;
  double maxQuantity;
  String itemType;
  String promoItemNumberRef;
  double stdFreeGoodPct;
  String stdFreeGoodItemNumberRef;

  // rebate
  double rebateTier;
  double rebateAmount;
  String rebateUomCode;
  String rebateCurrencyCode;

  //mark tolerance
  double tolerance;

  // discount
  bool entitleDiscount;
  // mark discount process
  bool priceRequestComplete;

//  priceLimitRule: PriceLimitRule;
//  quantitySpotPricing: QuantitySpotPricing;
//  quantityDeviationRule: QuantityDeviationRule;

  String pricingFormula;
  double pricingAlpha;

  //Transient
  bool isChecked;
  double stockRemaining;

  CommonItem(
      {this.itemNumber,
      this.product,
      this.sku,
      this.characteristicValues,
      this.quantity,
      this.invoicePrice,
      this.currencyCode,
      this.uomCode,
      this.incotermCode,
      this.tradeType,
      this.deliveryMode,
      this.shippingConditionCode,
      this.shippingConditionCode2,
      this.shortTermQuantity,
      this.containerCapacity,
      this.priceType,
      this.pricingPower,
      this.containerCapacityFactor,
      this.promoType,
      this.discountPercentage,
      this.originalInvoicePrice,
      this.maxQuantity,
      this.itemType,
      this.promoItemNumberRef,
      this.stdFreeGoodPct,
      this.stdFreeGoodItemNumberRef,
      this.rebateTier,
      this.rebateAmount,
      this.rebateUomCode,
      this.rebateCurrencyCode,
      this.tolerance,
      this.entitleDiscount,
      this.priceRequestComplete,
      this.pricingFormula,
      this.pricingAlpha,
      this.isChecked,
      this.stockRemaining});

  factory CommonItem.fromJson(Map<String, dynamic> json) =>
      _$CommonItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommonItemToJson(this);
}
