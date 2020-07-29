// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery-schedule-item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryScheduleItem _$DeliveryScheduleItemFromJson(Map<String, dynamic> json) {
  return DeliveryScheduleItem(
    quantity: (json['quantity'] as num)?.toDouble(),
    itemNumber: json['itemNumber'] as String,
  );
}

Map<String, dynamic> _$DeliveryScheduleItemToJson(
        DeliveryScheduleItem instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'itemNumber': instance.itemNumber,
    };
