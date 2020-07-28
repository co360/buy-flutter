import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/document.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/common-doc.dart';
import 'package:storeFlutter/models/shopping/customer.dart';
import 'package:storeFlutter/models/shopping/quote-item.dart';

part 'quote-doc.g.dart';

@JsonSerializable()
class QuoteDoc extends CommonDoc {
  int id;
  Location billingAddress;
  Customer shipToCustomer;
  String paymentMethodName;
  String paymentTermName;
  String status;
  String statusName;
  String additionalInfo;
  Account requestorAccount;
  Company requestorCompany;
  Company responsorToRequestorCompany;
  List<Document> attachments = [];
  int buyerCompanyId;
  LocalDateTime offerValidDate;
  String validDateType;
  List<QuoteItem> quoteItems;
  LocalDateTime dateCreated;
  LocalDateTime dateAcknowledged;
  LocalDateTime dateResponded;
  LocalDateTime dateReminded;
  LocalDateTime dateCancelled;
  LocalDateTime dateDeclined;
  LocalDateTime dateAccepted;
  String type = 'USER'; // default to user
  String timeDifference;
  int sellerCompanyId;

  QuoteDoc(
      {this.id,
      this.billingAddress,
      this.shipToCustomer,
      this.paymentMethodName,
      this.paymentTermName,
      this.status,
      this.statusName,
      this.additionalInfo,
      this.requestorAccount,
      this.requestorCompany,
      this.responsorToRequestorCompany,
      this.attachments,
      this.buyerCompanyId,
      this.offerValidDate,
      this.validDateType,
      this.quoteItems,
      this.dateCreated,
      this.dateAcknowledged,
      this.dateResponded,
      this.dateReminded,
      this.dateCancelled,
      this.dateDeclined,
      this.dateAccepted,
      this.type,
      this.timeDifference,
      this.sellerCompanyId}); // for individual buyer grouping

  factory QuoteDoc.fromJson(Map<String, dynamic> json) =>
      _$QuoteDocFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteDocToJson(this);
}
