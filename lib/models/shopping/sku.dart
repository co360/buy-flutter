import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/uom.dart';
import 'package:storeFlutter/models/shopping/variant-value.dart';

part 'sku.g.dart';

@JsonSerializable()
class Sku {
  bool isEnabled;
  String skuCode;
  String skuUuid;
  int productSkuID;
  List<VariantValue> variantValues;
  Uom skuSalesUnit;

  Sku(this.isEnabled, this.skuCode, this.skuUuid, this.productSkuID,
      this.variantValues, this.skuSalesUnit);

  factory Sku.fromJson(Map<String, dynamic> json) => _$SkuFromJson(json);

  Map<String, dynamic> toJson() => _$SkuToJson(this);
}
