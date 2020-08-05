// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easy-parcel-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EasyParcelResponse _$EasyParcelResponseFromJson(Map<String, dynamic> json) {
  return EasyParcelResponse(
    id: json['id'] as int,
    source: json['source'] as String,
    rate_id: json['rate_id'] as String,
    service_id: json['service_id'] as String,
    service_name: json['service_name'] as String,
    service_type: json['service_type'] as String,
    courier_id: json['courier_id'] as String,
    courier_name: json['courier_name'] as String,
    courier_logo: json['courier_logo'] as String,
    scheduled_start_date: json['scheduled_start_date'] as String,
    pickup_date: json['pickup_date'] == null
        ? null
        : LocalDate.fromJson(json['pickup_date'] as Map<String, dynamic>),
    delivery: json['delivery'] as String,
    delivery_dates: json['delivery_dates'] == null
        ? null
        : LocalDateRange.fromJson(
            json['delivery_dates'] as Map<String, dynamic>),
    price: (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$EasyParcelResponseToJson(EasyParcelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'rate_id': instance.rate_id,
      'service_id': instance.service_id,
      'service_name': instance.service_name,
      'service_type': instance.service_type,
      'courier_id': instance.courier_id,
      'courier_name': instance.courier_name,
      'courier_logo': instance.courier_logo,
      'scheduled_start_date': instance.scheduled_start_date,
      'pickup_date': instance.pickup_date,
      'delivery': instance.delivery,
      'delivery_dates': instance.delivery_dates,
      'price': instance.price,
    };
