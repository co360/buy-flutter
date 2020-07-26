// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    json['id'] as int,
    json['userName'] as String,
    json['password'] as String,
    json['name'] as String,
    json['lastName'] as String,
    json['firstName'] as String,
    json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
    json['designation'] == null
        ? null
        : Designation.fromJson(json['designation'] as Map<String, dynamic>),
    json['email'] as String,
    json['recoveryEmail'] as String,
    json['contactNo'] as String,
    json['country'] as String,
    json['cityState'] as String,
    json['timezone'] as String,
    json['passwordReset'] as bool,
    json['reportTo'] as int,
    json['linkedIn'] as String,
    json['status'] as int,
    json['division'] as String,
    json['jobTitle'] as String,
    (json['roles'] as List)
        ?.map(
            (e) => e == null ? null : Role.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['accountType'] as String,
    json['isMember'] as bool,
  )..profilePic = json['profilePic'] == null
      ? null
      : Image.fromJson(json['profilePic'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'password': instance.password,
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
      'passwordReset': instance.passwordReset,
      'reportTo': instance.reportTo,
      'linkedIn': instance.linkedIn,
      'profilePic': instance.profilePic,
      'status': instance.status,
      'division': instance.division,
      'jobTitle': instance.jobTitle,
      'roles': instance.roles,
      'accountType': instance.accountType,
      'isMember': instance.isMember,
    };
