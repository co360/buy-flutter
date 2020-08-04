import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/shopping/currency.dart';
import 'package:storeFlutter/models/shopping/product-sku.dart';
import 'package:storeFlutter/models/shopping/uom.dart';

part 'consumer-product-list-price.g.dart';

@JsonSerializable()
class ConsumerProductListPrice {
  int consumerProductListPriceID;
  double price;
  LocalDateTime effectiveDate;
  ProductSku productSku;
  String countryCode;
  Currency currency;
  Uom uom;

  //transient
  String priceDesc;

  ConsumerProductListPrice(
      {this.consumerProductListPriceID,
      this.price,
      this.effectiveDate,
      this.productSku,
      this.countryCode,
      this.currency,
      this.uom,
      this.priceDesc});

  factory ConsumerProductListPrice.fromJson(Map<String, dynamic> json) =>
      _$ConsumerProductListPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ConsumerProductListPriceToJson(this);
}
