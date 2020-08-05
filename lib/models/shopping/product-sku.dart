import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/uom.dart';

part 'product-sku.g.dart';

@JsonSerializable()
class ProductSku {
  int productSkuID;
  String code;
  String name;
  String description;
  int catalogProductID;
  Uom salesUnit;
  String recordStatus;

  ProductSku(
      {this.productSkuID,
      this.code,
      this.name,
      this.description,
      this.catalogProductID,
      this.salesUnit,
      this.recordStatus});

  factory ProductSku.fromJson(Map<String, dynamic> json) =>
      _$ProductSkuFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSkuToJson(this);
}
