// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current-user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return CurrentUser(
    json['username'] as String,
    json['authorities'] as List,
    json['firstName'] as String,
    json['lastName'] as String,
    json['email'] as String,
    json['companyId'] as int,
    json['companyCode'] as String,
  );
}

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      'username': instance.username,
      'authorities': instance.authorities,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'companyId': instance.companyId,
      'companyCode': instance.companyCode,
    };
