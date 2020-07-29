import 'package:json_annotation/json_annotation.dart';

part 'common-doc.g.dart';

@JsonSerializable()
class CommonDoc {
  int soldToCustomerID;
  String paymentMethod;
  String paymentTerm;
//  deliverySchedules: DeliverySchedule[] = [];
  String salesType;
  String contractQuantityType;
  bool promoDoc;
//  salesRebates: SalesRebate[] = [];
  bool advancedContract;

  String sellerCompanyName;

  CommonDoc(
      {this.soldToCustomerID,
      this.paymentMethod,
      this.paymentTerm,
      this.salesType,
      this.contractQuantityType,
      this.promoDoc,
      this.advancedContract,
      this.sellerCompanyName});

  factory CommonDoc.fromJson(Map<String, dynamic> json) =>
      _$CommonDocFromJson(json);

  Map<String, dynamic> toJson() => _$CommonDocToJson(this);
}
