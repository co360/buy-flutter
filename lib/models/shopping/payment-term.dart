import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/payment-method.dart';

part 'payment-term.g.dart';

@JsonSerializable()
class PaymentTerm {
  int paymentTermID;
  int companyId;
  String code;
  String name;
  PaymentMethod paymentMethod;
  String dueReference;
  String paymentTermType;
  int usance;
  int earlyDiscount;
  String earlyDiscountPeriod;
  String displayName;
  String paymentTermTypeName;

  int proportion;
  bool additionalPaymentTerm;
  int proportion2;
  PaymentMethod paymentMethod2;
  String dueReference2;
  int usance2;
  int earlyDiscount2;
  String earlyDiscountPeriod2;
//  paymentTermIntegrations: PaymentTermIntegration[];
  String displayInternalCode;

  PaymentTerm(
      {this.paymentTermID,
      this.companyId,
      this.code,
      this.name,
      this.paymentMethod,
      this.dueReference,
      this.paymentTermType,
      this.usance,
      this.earlyDiscount,
      this.earlyDiscountPeriod,
      this.displayName,
      this.paymentTermTypeName,
      this.proportion,
      this.additionalPaymentTerm,
      this.proportion2,
      this.paymentMethod2,
      this.dueReference2,
      this.usance2,
      this.earlyDiscount2,
      this.earlyDiscountPeriod2,
      this.displayInternalCode});

  factory PaymentTerm.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermToJson(this);
}
