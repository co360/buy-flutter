// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote-doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteDoc _$QuoteDocFromJson(Map<String, dynamic> json) {
  return QuoteDoc(
    id: json['id'] as int,
    billingAddress: json['billingAddress'] == null
        ? null
        : Location.fromJson(json['billingAddress'] as Map<String, dynamic>),
    shipToCustomer: json['shipToCustomer'] == null
        ? null
        : Customer.fromJson(json['shipToCustomer'] as Map<String, dynamic>),
    paymentMethodName: json['paymentMethodName'] as String,
    paymentTermName: json['paymentTermName'] as String,
    status: json['status'] as String,
    statusName: json['statusName'] as String,
    additionalInfo: json['additionalInfo'] as String,
    requestorAccount: json['requestorAccount'] == null
        ? null
        : Account.fromJson(json['requestorAccount'] as Map<String, dynamic>),
    requestorCompany: json['requestorCompany'] == null
        ? null
        : Company.fromJson(json['requestorCompany'] as Map<String, dynamic>),
    responsorToRequestorCompany: json['responsorToRequestorCompany'] == null
        ? null
        : Company.fromJson(
            json['responsorToRequestorCompany'] as Map<String, dynamic>),
    attachments: (json['attachments'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    buyerCompanyId: json['buyerCompanyId'] as int,
    offerValidDate: json['offerValidDate'] == null
        ? null
        : LocalDateTime.fromJson(
            json['offerValidDate'] as Map<String, dynamic>),
    validDateType: json['validDateType'] as String,
    quoteItems: (json['quoteItems'] as List)
        ?.map((e) =>
            e == null ? null : QuoteItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dateCreated: json['dateCreated'] == null
        ? null
        : LocalDateTime.fromJson(json['dateCreated'] as Map<String, dynamic>),
    dateAcknowledged: json['dateAcknowledged'] == null
        ? null
        : LocalDateTime.fromJson(
            json['dateAcknowledged'] as Map<String, dynamic>),
    dateResponded: json['dateResponded'] == null
        ? null
        : LocalDateTime.fromJson(json['dateResponded'] as Map<String, dynamic>),
    dateReminded: json['dateReminded'] == null
        ? null
        : LocalDateTime.fromJson(json['dateReminded'] as Map<String, dynamic>),
    dateCancelled: json['dateCancelled'] == null
        ? null
        : LocalDateTime.fromJson(json['dateCancelled'] as Map<String, dynamic>),
    dateDeclined: json['dateDeclined'] == null
        ? null
        : LocalDateTime.fromJson(json['dateDeclined'] as Map<String, dynamic>),
    dateAccepted: json['dateAccepted'] == null
        ? null
        : LocalDateTime.fromJson(json['dateAccepted'] as Map<String, dynamic>),
    type: json['type'] as String,
    timeDifference: json['timeDifference'] as String,
    sellerCompanyId: json['sellerCompanyId'] as int,
  )
    ..soldToCustomerID = json['soldToCustomerID'] as int
    ..paymentMethod = json['paymentMethod'] as String
    ..paymentTerm = json['paymentTerm'] as String
    ..salesType = json['salesType'] as String
    ..contractQuantityType = json['contractQuantityType'] as String
    ..promoDoc = json['promoDoc'] as bool
    ..advancedContract = json['advancedContract'] as bool
    ..sellerCompanyName = json['sellerCompanyName'] as String;
}

Map<String, dynamic> _$QuoteDocToJson(QuoteDoc instance) => <String, dynamic>{
      'soldToCustomerID': instance.soldToCustomerID,
      'paymentMethod': instance.paymentMethod,
      'paymentTerm': instance.paymentTerm,
      'salesType': instance.salesType,
      'contractQuantityType': instance.contractQuantityType,
      'promoDoc': instance.promoDoc,
      'advancedContract': instance.advancedContract,
      'sellerCompanyName': instance.sellerCompanyName,
      'id': instance.id,
      'billingAddress': instance.billingAddress,
      'shipToCustomer': instance.shipToCustomer,
      'paymentMethodName': instance.paymentMethodName,
      'paymentTermName': instance.paymentTermName,
      'status': instance.status,
      'statusName': instance.statusName,
      'additionalInfo': instance.additionalInfo,
      'requestorAccount': instance.requestorAccount,
      'requestorCompany': instance.requestorCompany,
      'responsorToRequestorCompany': instance.responsorToRequestorCompany,
      'attachments': instance.attachments,
      'buyerCompanyId': instance.buyerCompanyId,
      'offerValidDate': instance.offerValidDate,
      'validDateType': instance.validDateType,
      'quoteItems': instance.quoteItems,
      'dateCreated': instance.dateCreated,
      'dateAcknowledged': instance.dateAcknowledged,
      'dateResponded': instance.dateResponded,
      'dateReminded': instance.dateReminded,
      'dateCancelled': instance.dateCancelled,
      'dateDeclined': instance.dateDeclined,
      'dateAccepted': instance.dateAccepted,
      'type': instance.type,
      'timeDifference': instance.timeDifference,
      'sellerCompanyId': instance.sellerCompanyId,
    };
