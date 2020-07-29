// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer-type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerType _$CustomerTypeFromJson(Map<String, dynamic> json) {
  return CustomerType(
    customerTypeID: json['customerTypeID'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$CustomerTypeToJson(CustomerType instance) =>
    <String, dynamic>{
      'customerTypeID': instance.customerTypeID,
      'name': instance.name,
      'code': instance.code,
      'status': instance.status,
    };
