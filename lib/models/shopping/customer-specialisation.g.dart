// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer-specialisation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerSpecialisation _$CustomerSpecialisationFromJson(
    Map<String, dynamic> json) {
  return CustomerSpecialisation(
    customerSpecialisationID: json['customerSpecialisationID'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$CustomerSpecialisationToJson(
        CustomerSpecialisation instance) =>
    <String, dynamic>{
      'customerSpecialisationID': instance.customerSpecialisationID,
      'name': instance.name,
      'code': instance.code,
      'status': instance.status,
    };
