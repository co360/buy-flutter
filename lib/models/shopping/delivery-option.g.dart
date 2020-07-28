// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery-option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOption _$DeliveryOptionFromJson(Map<String, dynamic> json) {
  return DeliveryOption(
    portName: json['portName'] as String,
    portAddress: json['portAddress'] as String,
    countryName: json['countryName'] as String,
    nearestPortCountryName: json['nearestPortCountryName'] as String,
    toPort: json['toPort'] as bool,
    toBuyer: json['toBuyer'] as bool,
    imageUrl: json['imageUrl'] as String,
    selected: json['selected'] as bool,
    defaultSupplyLocation: json['defaultSupplyLocation'] as bool,
    newLocation: json['newLocation'] as bool,
  )
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..code = json['code'] as String
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..address = json['address'] as String
    ..countryCode = json['countryCode'] as String
    ..nearestPortCountry = json['nearestPortCountry'] as String
    ..portCode = json['portCode'] as String
    ..deliveryLocation = json['deliveryLocation'] as bool
    ..supplyLocation = json['supplyLocation'] as bool
    ..postcode = json['postcode'] as String
    ..state = json['state'] as String
    ..city = json['city'] as String;
}

Map<String, dynamic> _$DeliveryOptionToJson(DeliveryOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'countryCode': instance.countryCode,
      'nearestPortCountry': instance.nearestPortCountry,
      'portCode': instance.portCode,
      'deliveryLocation': instance.deliveryLocation,
      'supplyLocation': instance.supplyLocation,
      'postcode': instance.postcode,
      'state': instance.state,
      'city': instance.city,
      'portName': instance.portName,
      'portAddress': instance.portAddress,
      'countryName': instance.countryName,
      'nearestPortCountryName': instance.nearestPortCountryName,
      'toPort': instance.toPort,
      'toBuyer': instance.toBuyer,
      'imageUrl': instance.imageUrl,
      'selected': instance.selected,
      'defaultSupplyLocation': instance.defaultSupplyLocation,
      'newLocation': instance.newLocation,
    };
