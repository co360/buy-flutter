// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    json['id'] as int,
    json['name'] as String,
    json['address1'] as String,
    json['address2'] as String,
    json['address3'] as String,
    json['generalLine'] as String,
    json['faxNumber'] as String,
    json['timeZone'] as String,
    json['countryName'] as String,
    json['country'] as String,
    json['servicePackage'] as String,
    json['website'] as String,
    json['adminEmail'] as String,
    json['type'] as String,
    json['uuid'] as String,
    json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>),
    json['industry'] as String,
    json['totalEmployees'] as String,
    json['yearRegistered'] as String,
    (json['businessType'] as List)?.map((e) => e as String)?.toList(),
    (json['businessActivity'] as List)?.map((e) => e as String)?.toList(),
    json['postcode'] as String,
    json['state'] as String,
    json['city'] as String,
    json['otherIdNo'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'generalLine': instance.generalLine,
      'faxNumber': instance.faxNumber,
      'timeZone': instance.timeZone,
      'countryName': instance.countryName,
      'country': instance.country,
      'servicePackage': instance.servicePackage,
      'website': instance.website,
      'adminEmail': instance.adminEmail,
      'type': instance.type,
      'uuid': instance.uuid,
      'image': instance.image,
      'industry': instance.industry,
      'totalEmployees': instance.totalEmployees,
      'yearRegistered': instance.yearRegistered,
      'businessType': instance.businessType,
      'businessActivity': instance.businessActivity,
      'postcode': instance.postcode,
      'state': instance.state,
      'city': instance.city,
      'otherIdNo': instance.otherIdNo,
    };
