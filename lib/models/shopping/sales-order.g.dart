// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales-order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesOrder _$SalesOrderFromJson(Map<String, dynamic> json) {
  return SalesOrder(
    json['id'] as int,
    json['salesOrderNumber'] as String,
    json['purchaseOrderNumber'] as String,
    json['billingAddress'] == null
        ? null
        : Location.fromJson(json['billingAddress'] as Map<String, dynamic>),
    json['requestorAccount'] == null
        ? null
        : Account.fromJson(json['requestorAccount'] as Map<String, dynamic>),
    json['requestorCompany'] == null
        ? null
        : Company.fromJson(json['requestorCompany'] as Map<String, dynamic>),
    json['dateIssued'] == null
        ? null
        : LocalDateTime.fromJson(json['dateIssued'] as Map<String, dynamic>),
    json['datePaid'] == null
        ? null
        : LocalDateTime.fromJson(json['datePaid'] as Map<String, dynamic>),
    json['dateShipped'] == null
        ? null
        : LocalDateTime.fromJson(json['dateShipped'] as Map<String, dynamic>),
    json['dateReceived'] == null
        ? null
        : LocalDateTime.fromJson(json['dateReceived'] as Map<String, dynamic>),
    json['dateCompleted'] == null
        ? null
        : LocalDateTime.fromJson(json['dateCompleted'] as Map<String, dynamic>),
    json['orderStatus'] as String,
    json['additionalInfo'] as String,
    json['shipToCustomer'] == null
        ? null
        : Customer.fromJson(json['shipToCustomer'] as Map<String, dynamic>),
    (json['attachments'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['paymentMethodName'] as String,
    json['paymentTermName'] as String,
    json['statusName'] as String,
    json['buyerCompanyId'] as int,
    (json['orderItems'] as List)
        ?.map((e) =>
            e == null ? null : CommonItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['deliverySchedule'] == null
        ? null
        : DeliverySchedule.fromJson(
            json['deliverySchedule'] as Map<String, dynamic>),
    json['productName'] as String,
    json['favouriteOrder'] as bool,
    json['favouriteEnquiry'] as bool,
    json['blDate'] == null
        ? null
        : LocalDate.fromJson(json['blDate'] as Map<String, dynamic>),
    json['invoiceDate'] == null
        ? null
        : LocalDate.fromJson(json['invoiceDate'] as Map<String, dynamic>),
    json['deliveryDate'] == null
        ? null
        : LocalDate.fromJson(json['deliveryDate'] as Map<String, dynamic>),
    json['paymentDueDate'] == null
        ? null
        : LocalDate.fromJson(json['paymentDueDate'] as Map<String, dynamic>),
    json['requestedDeliveryEta'] == null
        ? null
        : LocalDateRange.fromJson(
            json['requestedDeliveryEta'] as Map<String, dynamic>),
    json['requestedDeliveryEtd'] == null
        ? null
        : LocalDateRange.fromJson(
            json['requestedDeliveryEtd'] as Map<String, dynamic>),
    json['paymentReceived'] as bool,
    json['storeShippingOption'] == null
        ? null
        : StoreShippingOption.fromJson(
            json['storeShippingOption'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SalesOrderToJson(SalesOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salesOrderNumber': instance.salesOrderNumber,
      'purchaseOrderNumber': instance.purchaseOrderNumber,
      'billingAddress': instance.billingAddress,
      'requestorAccount': instance.requestorAccount,
      'requestorCompany': instance.requestorCompany,
      'dateIssued': instance.dateIssued,
      'datePaid': instance.datePaid,
      'dateShipped': instance.dateShipped,
      'dateReceived': instance.dateReceived,
      'dateCompleted': instance.dateCompleted,
      'orderStatus': instance.orderStatus,
      'additionalInfo': instance.additionalInfo,
      'shipToCustomer': instance.shipToCustomer,
      'attachments': instance.attachments,
      'paymentMethodName': instance.paymentMethodName,
      'paymentTermName': instance.paymentTermName,
      'statusName': instance.statusName,
      'buyerCompanyId': instance.buyerCompanyId,
      'orderItems': instance.orderItems,
      'deliverySchedule': instance.deliverySchedule,
      'productName': instance.productName,
      'favouriteOrder': instance.favouriteOrder,
      'favouriteEnquiry': instance.favouriteEnquiry,
      'blDate': instance.blDate,
      'invoiceDate': instance.invoiceDate,
      'deliveryDate': instance.deliveryDate,
      'paymentDueDate': instance.paymentDueDate,
      'requestedDeliveryEta': instance.requestedDeliveryEta,
      'requestedDeliveryEtd': instance.requestedDeliveryEtd,
      'paymentReceived': instance.paymentReceived,
      'storeShippingOption': instance.storeShippingOption,
    };
