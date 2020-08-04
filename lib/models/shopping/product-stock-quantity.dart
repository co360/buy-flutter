import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/product-sku.dart';

part 'product-stock-quantity.g.dart';

@JsonSerializable()
class ProductStockQuantity {
  int productStockQuantityID;
  double stock;
  ProductSku productSku;
  String countryCode;

  ProductStockQuantity(
      {this.productStockQuantityID,
      this.stock,
      this.productSku,
      this.countryCode});

  factory ProductStockQuantity.fromJson(Map<String, dynamic> json) =>
      _$ProductStockQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStockQuantityToJson(this);
}
