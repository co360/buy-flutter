// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['address'] as String,
    json['countryCode'] as String,
    json['nearestPortCountry'] as String,
    json['portCode'] as String,
    json['deliveryLocation'] as bool,
    json['supplyLocation'] as bool,
    json['postcode'] as String,
    json['state'] as String,
    json['city'] as String,
    json['portName'] as String,
    json['countryName'] as String,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
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
      'countryName': instance.countryName,
    };
