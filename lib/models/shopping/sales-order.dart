import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/document.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/shopping/customer.dart';
import 'package:storeFlutter/models/shopping/common-item.dart';
import 'package:storeFlutter/models/shopping/delivery-schedule.dart';
import 'package:storeFlutter/models/shopping/store-shipping-option.dart';

part 'sales-order.g.dart';

@JsonSerializable()
class SalesOrder {
  int id;
  String salesOrderNumber;
  String purchaseOrderNumber;

  Location billingAddress;
  Account requestorAccount;
  Company requestorCompany;
  LocalDateTime dateIssued;
  LocalDateTime datePaid;
  LocalDateTime dateShipped;
  LocalDateTime dateReceived;
  LocalDateTime dateCompleted;
  String orderStatus;
  String additionalInfo;
  Customer shipToCustomer;
  List<Document> attachments;
  String paymentMethodName;
  String paymentTermName;
  String statusName;
  int buyerCompanyId;
  List<CommonItem> orderItems;
  DeliverySchedule deliverySchedule;
  // currentStage: OrderStage;
  // orderStages: OrderStage[] = []; d
  String productName;
  // paymentDocuments: PaymentDocument[] = [];
  // payment: PaymentTT;
  // paymentLC: PaymentLC;

  bool favouriteOrder;
  bool favouriteEnquiry;

  LocalDate blDate;
  LocalDate invoiceDate;
  LocalDate deliveryDate;
  LocalDate paymentDueDate;
  LocalDateRange requestedDeliveryEta;
  LocalDateRange requestedDeliveryEtd;
  bool paymentReceived;
  // productInventories: ProductInventory[] = [];
  // certificateAnalysis: CertificateAnalysis;
  StoreShippingOption storeShippingOption;

  SalesOrder(
      this.id,
      this.salesOrderNumber,
      this.purchaseOrderNumber,
      this.billingAddress,
      this.requestorAccount,
      this.requestorCompany,
      this.dateIssued,
      this.datePaid,
      this.dateShipped,
      this.dateReceived,
      this.dateCompleted,
      this.orderStatus,
      this.additionalInfo,
      this.shipToCustomer,
      this.attachments,
      this.paymentMethodName,
      this.paymentTermName,
      this.statusName,
      this.buyerCompanyId,
      this.orderItems,
      this.deliverySchedule,
      this.productName,
      this.favouriteOrder,
      this.favouriteEnquiry,
      this.blDate,
      this.invoiceDate,
      this.deliveryDate,
      this.paymentDueDate,
      this.requestedDeliveryEta,
      this.requestedDeliveryEtd,
      this.paymentReceived,
      this.storeShippingOption);

  factory SalesOrder.fromJson(Map<String, dynamic> json) =>
      _$SalesOrderFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderToJson(this);
}
