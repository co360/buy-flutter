import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/delivery-option.dart';
import 'package:storeFlutter/models/shopping/delivery-schedule-item.dart';

part 'delivery-schedule.g.dart';

@JsonSerializable()
class DeliverySchedule {
  int shipToCustomerID;
  bool newLocation;
  Location shippingAddress;
  Location supplyLocation;
  LocalDateRange deliveryDate;
  String incotermCode;
  String tradeType;
  String deliveryMode;
  String shippingConditionCode;
  String shippingConditionCode2;
  List<DeliveryScheduleItem> deliveryScheduleItems = [];
  String deliveryDateOption;
  int salesOrderId;
  String salesOrderNumber;
  String purchaseOrderNumber;
  bool incotermToPort;
  LocalDateTime productLeadTime;
  int salesContractId;
  String salesContractNumber;
  String purchaseContractNumber;
  double shippedQuantity;
  double shippedAmount;

  LocalDateTime plannedDeliveryEta;
  LocalDateTime revisedDeliveryEta;
  LocalDateTime actualDeliveryEta;
  LocalDateTime plannedDeliveryEtd;
  LocalDateTime revisedDeliveryEtd;
  LocalDateTime actualDeliveryEtd;
  String vesselName;
  String vesselTrackingUrl;
  String truckCompany;
  String truckSize;
  int numberOfTruck;
  String supplyOrigin;
  String loadingPort;
  String dischargePort;
  String deliveryDestination;
  String supplyCity;
  String deliveryCity;

  String shippingCompany;
  String containerSize;
  int numberOfContainer;
//  vesselSchedule: ContainerVesselSchedule;

  // transient fields
  DeliveryOption shippingAddressOption;
  String incotermDeliveryMode;

  DeliverySchedule(
      {this.shipToCustomerID,
      this.newLocation,
      this.shippingAddress,
      this.supplyLocation,
      this.deliveryDate,
      this.incotermCode,
      this.tradeType,
      this.deliveryMode,
      this.shippingConditionCode,
      this.shippingConditionCode2,
      this.deliveryScheduleItems,
      this.deliveryDateOption,
      this.salesOrderId,
      this.salesOrderNumber,
      this.purchaseOrderNumber,
      this.incotermToPort,
      this.productLeadTime,
      this.salesContractId,
      this.salesContractNumber,
      this.purchaseContractNumber,
      this.shippedQuantity,
      this.shippedAmount,
      this.plannedDeliveryEta,
      this.revisedDeliveryEta,
      this.actualDeliveryEta,
      this.plannedDeliveryEtd,
      this.revisedDeliveryEtd,
      this.actualDeliveryEtd,
      this.vesselName,
      this.vesselTrackingUrl,
      this.truckCompany,
      this.truckSize,
      this.numberOfTruck,
      this.supplyOrigin,
      this.loadingPort,
      this.dischargePort,
      this.deliveryDestination,
      this.supplyCity,
      this.deliveryCity,
      this.shippingCompany,
      this.containerSize,
      this.numberOfContainer,
      this.shippingAddressOption,
      this.incotermDeliveryMode});

  factory DeliverySchedule.fromJson(Map<String, dynamic> json) =>
      _$DeliveryScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryScheduleToJson(this);
}
