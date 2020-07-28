// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery-schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliverySchedule _$DeliveryScheduleFromJson(Map<String, dynamic> json) {
  return DeliverySchedule(
    shipToCustomerID: json['shipToCustomerID'] as int,
    newLocation: json['newLocation'] as bool,
    shippingAddress: json['shippingAddress'] == null
        ? null
        : Location.fromJson(json['shippingAddress'] as Map<String, dynamic>),
    supplyLocation: json['supplyLocation'] == null
        ? null
        : Location.fromJson(json['supplyLocation'] as Map<String, dynamic>),
    deliveryDate: json['deliveryDate'] == null
        ? null
        : LocalDateRange.fromJson(json['deliveryDate'] as Map<String, dynamic>),
    incotermCode: json['incotermCode'] as String,
    tradeType: json['tradeType'] as String,
    deliveryMode: json['deliveryMode'] as String,
    shippingConditionCode: json['shippingConditionCode'] as String,
    shippingConditionCode2: json['shippingConditionCode2'] as String,
    deliveryScheduleItems: (json['deliveryScheduleItems'] as List)
        ?.map((e) => e == null
            ? null
            : DeliveryScheduleItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    deliveryDateOption: json['deliveryDateOption'] as String,
    salesOrderId: json['salesOrderId'] as int,
    salesOrderNumber: json['salesOrderNumber'] as String,
    purchaseOrderNumber: json['purchaseOrderNumber'] as String,
    incotermToPort: json['incotermToPort'] as bool,
    productLeadTime: json['productLeadTime'] == null
        ? null
        : LocalDateTime.fromJson(
            json['productLeadTime'] as Map<String, dynamic>),
    salesContractId: json['salesContractId'] as int,
    salesContractNumber: json['salesContractNumber'] as String,
    purchaseContractNumber: json['purchaseContractNumber'] as String,
    shippedQuantity: (json['shippedQuantity'] as num)?.toDouble(),
    shippedAmount: (json['shippedAmount'] as num)?.toDouble(),
    plannedDeliveryEta: json['plannedDeliveryEta'] == null
        ? null
        : LocalDateTime.fromJson(
            json['plannedDeliveryEta'] as Map<String, dynamic>),
    revisedDeliveryEta: json['revisedDeliveryEta'] == null
        ? null
        : LocalDateTime.fromJson(
            json['revisedDeliveryEta'] as Map<String, dynamic>),
    actualDeliveryEta: json['actualDeliveryEta'] == null
        ? null
        : LocalDateTime.fromJson(
            json['actualDeliveryEta'] as Map<String, dynamic>),
    plannedDeliveryEtd: json['plannedDeliveryEtd'] == null
        ? null
        : LocalDateTime.fromJson(
            json['plannedDeliveryEtd'] as Map<String, dynamic>),
    revisedDeliveryEtd: json['revisedDeliveryEtd'] == null
        ? null
        : LocalDateTime.fromJson(
            json['revisedDeliveryEtd'] as Map<String, dynamic>),
    actualDeliveryEtd: json['actualDeliveryEtd'] == null
        ? null
        : LocalDateTime.fromJson(
            json['actualDeliveryEtd'] as Map<String, dynamic>),
    vesselName: json['vesselName'] as String,
    vesselTrackingUrl: json['vesselTrackingUrl'] as String,
    truckCompany: json['truckCompany'] as String,
    truckSize: json['truckSize'] as String,
    numberOfTruck: json['numberOfTruck'] as int,
    supplyOrigin: json['supplyOrigin'] as String,
    loadingPort: json['loadingPort'] as String,
    dischargePort: json['dischargePort'] as String,
    deliveryDestination: json['deliveryDestination'] as String,
    supplyCity: json['supplyCity'] as String,
    deliveryCity: json['deliveryCity'] as String,
    shippingCompany: json['shippingCompany'] as String,
    containerSize: json['containerSize'] as String,
    numberOfContainer: json['numberOfContainer'] as int,
    shippingAddressOption: json['shippingAddressOption'] == null
        ? null
        : DeliveryOption.fromJson(
            json['shippingAddressOption'] as Map<String, dynamic>),
    incotermDeliveryMode: json['incotermDeliveryMode'] as String,
  );
}

Map<String, dynamic> _$DeliveryScheduleToJson(DeliverySchedule instance) =>
    <String, dynamic>{
      'shipToCustomerID': instance.shipToCustomerID,
      'newLocation': instance.newLocation,
      'shippingAddress': instance.shippingAddress,
      'supplyLocation': instance.supplyLocation,
      'deliveryDate': instance.deliveryDate,
      'incotermCode': instance.incotermCode,
      'tradeType': instance.tradeType,
      'deliveryMode': instance.deliveryMode,
      'shippingConditionCode': instance.shippingConditionCode,
      'shippingConditionCode2': instance.shippingConditionCode2,
      'deliveryScheduleItems': instance.deliveryScheduleItems,
      'deliveryDateOption': instance.deliveryDateOption,
      'salesOrderId': instance.salesOrderId,
      'salesOrderNumber': instance.salesOrderNumber,
      'purchaseOrderNumber': instance.purchaseOrderNumber,
      'incotermToPort': instance.incotermToPort,
      'productLeadTime': instance.productLeadTime,
      'salesContractId': instance.salesContractId,
      'salesContractNumber': instance.salesContractNumber,
      'purchaseContractNumber': instance.purchaseContractNumber,
      'shippedQuantity': instance.shippedQuantity,
      'shippedAmount': instance.shippedAmount,
      'plannedDeliveryEta': instance.plannedDeliveryEta,
      'revisedDeliveryEta': instance.revisedDeliveryEta,
      'actualDeliveryEta': instance.actualDeliveryEta,
      'plannedDeliveryEtd': instance.plannedDeliveryEtd,
      'revisedDeliveryEtd': instance.revisedDeliveryEtd,
      'actualDeliveryEtd': instance.actualDeliveryEtd,
      'vesselName': instance.vesselName,
      'vesselTrackingUrl': instance.vesselTrackingUrl,
      'truckCompany': instance.truckCompany,
      'truckSize': instance.truckSize,
      'numberOfTruck': instance.numberOfTruck,
      'supplyOrigin': instance.supplyOrigin,
      'loadingPort': instance.loadingPort,
      'dischargePort': instance.dischargePort,
      'deliveryDestination': instance.deliveryDestination,
      'supplyCity': instance.supplyCity,
      'deliveryCity': instance.deliveryCity,
      'shippingCompany': instance.shippingCompany,
      'containerSize': instance.containerSize,
      'numberOfContainer': instance.numberOfContainer,
      'shippingAddressOption': instance.shippingAddressOption,
      'incotermDeliveryMode': instance.incotermDeliveryMode,
    };
