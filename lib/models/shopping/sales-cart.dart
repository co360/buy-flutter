import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/shopping/sales-quotation.dart';

part 'sales-cart.g.dart';

@JsonSerializable()
class SalesCart {
  int id;

  int accountId;

  LocalDate dateCreated;
  List<SalesQuotation> cartDocs;

  SalesCart({this.id, this.accountId, this.dateCreated, this.cartDocs});

  factory SalesCart.fromJson(Map<String, dynamic> json) =>
      _$SalesCartFromJson(json);

  Map<String, dynamic> toJson() => _$SalesCartToJson(this);

  int get totalItems {
    if (cartDocs == null || cartDocs.length == 0) return 0;
    return cartDocs.fold(
        0,
        (value, element) =>
            value +
            element.quoteItems.fold(
                0,
                (previousValue, item) =>
                    previousValue + item.quantity.toInt()));
  }
}
