// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    json['id'] as int,
    json['userName'] as String,
    json['name'] as String,
    json['lastName'] as String,
    json['firstName'] as String,
    json['email'] as String,
    json['recoveryEmail'] as String,
    json['contactNo'] as String,
    json['country'] as String,
    json['cityState'] as String,
    json['timezone'] as String,
    json['reportTo'] as int,
    json['linkedIn'] as String,
    json['status'] as int,
    json['division'] as String,
    json['jobTitle'] as String,
  )
    ..department = json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>)
    ..designation = json['designation'] == null
        ? null
        : Designation.fromJson(json['designation'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'department': instance.department,
      'designation': instance.designation,
      'email': instance.email,
      'recoveryEmail': instance.recoveryEmail,
      'contactNo': instance.contactNo,
      'country': instance.country,
      'cityState': instance.cityState,
      'timezone': instance.timezone,
      'reportTo': instance.reportTo,
      'linkedIn': instance.linkedIn,
      'status': instance.status,
      'division': instance.division,
      'jobTitle': instance.jobTitle,
    };
