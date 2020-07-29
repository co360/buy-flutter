import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/document.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/customer.dart';
import 'package:storeFlutter/models/shopping/delivery-option.dart';
import 'package:storeFlutter/models/shopping/quote-doc.dart';
import 'package:storeFlutter/models/shopping/quote-item.dart';
import 'package:storeFlutter/models/shopping/store-shipping-option.dart';

part 'sales-quotation.g.dart';

@JsonSerializable()
class SalesQuotation extends QuoteDoc {
  LocalDateTime dateCreated;
  String quotationNumber;
  String rfqNumber;
  String declineReason;
  bool checked = true;
  DeliveryOption newLocation;

  // for trader
  int traderReferenceDocID;

  // transient field
  bool entitleDiscount;
  StoreShippingOption storeShippingOption;

  SalesQuotation(
      {this.dateCreated,
      this.quotationNumber,
      this.rfqNumber,
      this.declineReason,
      this.checked,
      this.newLocation,
      this.traderReferenceDocID,
      this.entitleDiscount,
      this.storeShippingOption});

  factory SalesQuotation.fromJson(Map<String, dynamic> json) =>
      _$SalesQuotationFromJson(json);

  Map<String, dynamic> toJson() => _$SalesQuotationToJson(this);
}
