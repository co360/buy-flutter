import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/identity/location.dart';

part 'store-shipping-option.g.dart';

@JsonSerializable()
class StoreShippingOption {
  Location shippingAddress;
  Location billingAddress;
  String providerName;
  double shippingFee;
  LocalDateTime estimatedArrivalDate;
  String deliveredBy;
  String trackingNo;
  LocalDateTime deliveredDate;
  String currencyCode;
  LocalDateTime pickupDate;
  String serviceOrderNo;
  String serviceParcelNo;
  String serviceStatus;
  String remarks;

  StoreShippingOption(
      {this.shippingAddress,
      this.billingAddress,
      this.providerName,
      this.shippingFee,
      this.estimatedArrivalDate,
      this.deliveredBy,
      this.trackingNo,
      this.deliveredDate,
      this.currencyCode,
      this.pickupDate,
      this.serviceOrderNo,
      this.serviceParcelNo,
      this.serviceStatus,
      this.remarks});

  factory StoreShippingOption.fromJson(Map<String, dynamic> json) =>
      _$StoreShippingOptionFromJson(json);

  Map<String, dynamic> toJson() => _$StoreShippingOptionToJson(this);
}
