// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    id: json['id'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    address: json['address'] as String,
    countryCode: json['countryCode'] as String,
    nearestPortCountry: json['nearestPortCountry'] as String,
    portCode: json['portCode'] as String,
    deliveryLocation: json['deliveryLocation'] as bool,
    supplyLocation: json['supplyLocation'] as bool,
    postcode: json['postcode'] as String,
    state: json['state'] as String,
    city: json['city'] as String,
    fullName: json['fullName'] as String,
    phoneNo: json['phoneNo'] as String,
    locationType: json['locationType'] as String,
    defaultShipping: json['defaultShipping'] as bool,
    defaultBilling: json['defaultBilling'] as bool,
    portName: json['portName'] as String,
    countryName: json['countryName'] as String,
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
      'fullName': instance.fullName,
      'phoneNo': instance.phoneNo,
      'locationType': instance.locationType,
      'defaultShipping': instance.defaultShipping,
      'defaultBilling': instance.defaultBilling,
      'portName': instance.portName,
      'countryName': instance.countryName,
    };
