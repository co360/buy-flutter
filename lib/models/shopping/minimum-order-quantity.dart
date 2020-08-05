import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/shopping/product-sku.dart';
import 'package:storeFlutter/models/shopping/uom.dart';

part 'minimum-order-quantity.g.dart';

@JsonSerializable()
class MinimumOrderQuantity {
  int minOrderQtyID;
  ProductSku productSku;
  double minQuantity;
  Uom uom;
  LocalDateTime effectiveDate;

  //transient
  String minQuantityDesc;

  MinimumOrderQuantity(
      {this.minOrderQtyID,
      this.productSku,
      this.minQuantity,
      this.uom,
      this.effectiveDate,
      this.minQuantityDesc});

  factory MinimumOrderQuantity.fromJson(Map<String, dynamic> json) =>
      _$MinimumOrderQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$MinimumOrderQuantityToJson(this);
}
